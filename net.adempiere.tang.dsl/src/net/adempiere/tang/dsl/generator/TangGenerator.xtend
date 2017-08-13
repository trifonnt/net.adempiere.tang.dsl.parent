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

/**
 * Generates code from your model files on save.
 * 
 * See https://www.eclipse.org/Xtext/documentation/303_runtime_concepts.html#code-generation
 */
class TangGenerator extends AbstractGenerator {

	@Inject
	extension IQualifiedNameProvider

	@Inject // @Trifon
	extension TangTypeToJavaTypeConverter typeRepresentation;


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
					entity.fullyQualifiedName.toString("/") + ".java"
//					, "public class "+entity.name + " { }"
					, entity.generateJavaClass
				)
			}
		}

		//-03) Generate XML file with DB Migration(Liquibase)
		
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
}
