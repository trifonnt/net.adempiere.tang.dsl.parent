/*
 * generated by Xtext 2.12.0
 */
package net.adempiere.tang.dsl.generator

import org.eclipse.emf.ecore.resource.Resource
import org.eclipse.xtext.generator.AbstractGenerator
import org.eclipse.xtext.generator.IFileSystemAccess2
import org.eclipse.xtext.generator.IGeneratorContext
import net.adempiere.tang.dsl.tang.TangEntity
import net.adempiere.tang.dsl.tang.TangPackageDeclaration
import com.google.inject.Inject
import org.eclipse.xtext.naming.IQualifiedNameProvider
import net.adempiere.tang.dsl.tang.Field
import net.adempiere.tang.dsl.tang.TangType
import net.adempiere.tang.dsl.tang.TangAbstractEntity
import net.adempiere.tang.dsl.tang.TangAbstractType
import net.adempiere.tang.dsl.tang.BasicType
import net.adempiere.tang.dsl.tang.SubType
import net.adempiere.tang.dsl.tang.BasicIntegerType

/**
 * Generates code from your model files on save.
 * 
 * See https://www.eclipse.org/Xtext/documentation/303_runtime_concepts.html#code-generation
 */
class TangGenerator extends AbstractGenerator {

	//@Trifon
	@Inject
	extension IQualifiedNameProvider

	@Inject // @Trifon
	extension TangTypeToJavaTypeConverter javaTypeRepresentation;

	@Inject // @Trifon
	extension TangTypeToDbTypeConverter dbTypeRepresentation;

	@Inject // @Trifon
	extension StringUtils stringUtils;


	override void doGenerate(Resource resource, IFileSystemAccess2 fsa, IGeneratorContext context) {
		//+01) Generate tiny documentation.
		for (tangPackage : resource.allContents.toIterable.filter(TangPackageDeclaration)) {
//			val fileName = 'all-entities--'+ tangPackage.fullyQualifiedName +'.txt';

//src-gen/all-entities--/resource/tangdsl-sample-project-01/03_entities.tang.txt
//			val fileName = 'all-entities--'+ resource.URI.path +'.txt';

// src-gen/all-entities--03_entities.tang.txt
			val fileName = 'all-entities--'+ resource.URI.lastSegment +'.txt';
			fsa.generateFile(fileName, 'Entities in our System: ' + 
				tangPackage.elements
					.filter(TangEntity)
					.map[name]
					.join(', ')
			);
		}


		//+02) Generate Java Beans(JPA Entities)
		for (tangPackage : resource.allContents.toIterable.filter(TangPackageDeclaration)) {
			for (entity : tangPackage.elements.filter(TangEntity)) {
				fsa.generateFile(
//					tangPackage.name + '/' + entity.name +'.java'
					"src/main/" + entity.fullyQualifiedName.toString("/") + ".java"
//					, "public class "+entity.name + " { }"
					, entity.generateJavaClass
				)
			}
		}

		//-03) Generate XML file with DB Migration(Liquibase)
		for (tangPackage : resource.allContents.toIterable.filter(TangPackageDeclaration)) {
			for (entity : tangPackage.elements.filter(TangEntity)) {
				fsa.generateFile(
					"src/main/resources/config/liquibase/changelog/" +	entity.name + ".liquibase.xml" // entity.fullyQualifiedName.toString("/") + ".liquibase.xml"
					, entity.generateLiquibaseFile
				)
			}
		}
		//-04) Generate finders(Java interfaces) for Spring repository 
	}

	def generateJavaClass(TangEntity entity) {
		'''
		«IF entity.eContainer.fullyQualifiedName !== null»
		package «entity.eContainer.fullyQualifiedName»;
		
		«ENDIF»
		public class «entity.name» «IF entity.superEntity !== null»extends «entity.superEntity.fullyQualifiedName» «ENDIF»{
		
		«FOR field: entity.fields»
			«field.generateJavaField»
		«ENDFOR»

		«FOR field: entity.fields»
			«field.generateJavaGetterAndSetter»
		«ENDFOR»
		}
		'''
	}

	def generateJavaField(Field f) {
		'''
		
			private «IF f.fieldType instanceof TangAbstractEntity»transient «ENDIF»«f.fieldType.toJavaType» «f.name»;
			«IF f.fieldType instanceof TangAbstractEntity»
			«val fieldType = f.fieldType as TangAbstractEntity»
			private «fieldType.toJavaTypeOfPrimaryKey» «f.name»Id;
			«ENDIF»
		'''
	}
	def generateJavaGetterAndSetter(Field f) {
		'''
		
			public «f.fieldType.toJavaType» get«f.name.toFirstUpper»() {
				return «f.name»;
			}
			public void set«f.name.toFirstUpper»(«f.fieldType.toJavaType» «f.name») {
				this.«f.name» = «f.name»;
			}
		«IF f.fieldType instanceof TangAbstractEntity»
		«val fieldType = f.fieldType as TangAbstractEntity»
			public «fieldType.toJavaTypeOfPrimaryKey» get«f.name.toFirstUpper»Id() {
				return «f.name»Id;
			}
		«ENDIF»
		'''
	}

	def getFieldType(TangType tangType) {
//		if (tangType) {
			
//		}
	}

	def generateLiquibaseFile(TangEntity entity) {
		'''
		<?xml version="1.0" encoding="utf-8"?>
		<databaseChangeLog
				xmlns="http://www.liquibase.org/xml/ns/dbchangelog"
				xmlns:ext="http://www.liquibase.org/xml/ns/dbchangelog-ext"
				xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
				xsi:schemaLocation="http://www.liquibase.org/xml/ns/dbchangelog http://www.liquibase.org/xml/ns/dbchangelog/dbchangelog-3.5.xsd
														http://www.liquibase.org/xml/ns/dbchangelog-ext http://www.liquibase.org/xml/ns/dbchangelog/dbchangelog-ext.xsd">
		
			<property name="now" value="now()" dbms="h2"/>
		
			<property name="now" value="current_timestamp" dbms="postgresql"/>
		
			<property name="floatType" value="float4" dbms="postgresql, h2"/>
			<property name="floatType" value="float" dbms="mysql, oracle, mssql"/>
		
			<changeSet author="TrifonTrifonov" id="createTable-«entity.tableName.removeQuotes»">
				<createTable tableName=«entity.tableName»>
		«FOR field: entity.fields»
			«field.generateLiquibaseColumn»
		«ENDFOR»
				</createTable>
		«IF entity.primaryKey !== null»
			«entity.generateLiquibasePrimaryKey»
		«ENDIF»
			</changeSet>
		</databaseChangeLog>
		'''
	}
//«val fieldType = f.fieldType as TangAbstractType»
	def generateLiquibaseColumn(Field f) {
		var nullable = false;
		if (f.fieldType instanceof TangAbstractType && f.fieldType instanceof TangType && (f.fieldType instanceof BasicType || f.fieldType instanceof SubType)) {

			if (f.fieldType instanceof SubType) {
				val fieldType = f.fieldType as SubType;
				if (fieldType.allowNull) {
					nullable = true;
				}
			} else {
				val fieldType = f.fieldType as BasicType;
				if (fieldType.allowNull) {
					nullable = true;
				}
			}
			
			if (f.fieldType instanceof BasicIntegerType) {
				val fieldType = f.fieldType as BasicIntegerType;
				fieldType.defaultValue
			}
		}
		'''			<column name="«f.columnName»" type="«f.fieldType.toDbType»">
				<constraints nullable="«nullable»" />
			</column>
		'''
	}

	def generateLiquibasePrimaryKey(TangEntity entity) {
		var primaryKeyNames = entity.primaryKey.fields
//					.filter(TangEntity)
					.map[columnName]
					.join(', ');
		var primaryKeyName = entity.primaryKey.name;
		'''		<addPrimaryKey 
			columnNames="«primaryKeyNames»"
			constraintName="«primaryKeyName»"
			tableName="«entity.tableName.removeQuotes»"
			validate="true"/>
		'''
	}

}
