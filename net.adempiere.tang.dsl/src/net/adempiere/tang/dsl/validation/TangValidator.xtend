/*
 * generated by Xtext 2.12.0
 */
package net.adempiere.tang.dsl.validation

import org.eclipse.xtext.validation.Check
import net.adempiere.tang.dsl.tang.TangPackage
import net.adempiere.tang.dsl.tang.TangType
import net.adempiere.tang.dsl.tang.EntityViewAlias
import net.adempiere.tang.dsl.tang.EntityViewField
import net.adempiere.tang.dsl.tang.Field
import net.adempiere.tang.dsl.tang.TangAbstractElement
import net.adempiere.tang.dsl.tang.Tab
import net.adempiere.tang.dsl.tang.TangEntity

/**
 * This class contains custom validation rules. 
 *
 * See https://www.eclipse.org/Xtext/documentation/303_runtime_concepts.html#validation
 */
// @Trifon
class TangValidator extends AbstractTangValidator {

	protected static val ISSUE_CODE_PREFIX = "net.adempiere.tang.";

	public static val ENTITY_HIERARCHY_CYCLE = ISSUE_CODE_PREFIX + "EntityHierarchyCycle";
	public static val INVALID_TYPE_NAME = ISSUE_CODE_PREFIX + "InvalidTypeName";
	public static val ENTITY_HAS_NO_FIELDS = ISSUE_CODE_PREFIX + "EntityHasNoFields";

	public static val INVALID_ENTITY_NAME = ISSUE_CODE_PREFIX + "InvalidEntityName";
	public static val INVALID_ATTRIBUTE_NAME = ISSUE_CODE_PREFIX + "InvalidAttributeName";

	public static val DUPLICATE_FIELD_NAME = ISSUE_CODE_PREFIX + "DuplicateFieldName";

	public static val INVALID_NAME = ISSUE_CODE_PREFIX + 'InvalidName';


// - Cycle in Entity hierarchy
	@Check
	def checkNoCycleInEntityHierarchy(TangEntity tangEntity) {
		if (tangEntity.superEntity === null) {
			return // Nothing to check
		}
		var visitedEntities = newHashSet(tangEntity);
		var current = tangEntity.superEntity;
		while (current !== null) {
			if (visitedEntities.contains(current)) {
				error("Cycle in hierarchy of entity '"+ current.name +"'"
//					, TangPackage.eINSTANCE.tangEntity_SuperEntity // This
					, TangPackage.Literals.TANG_ENTITY__SUPER_ENTITY // OR this
					, ENTITY_HIERARCHY_CYCLE   // issue code
					, current.superEntity.name // issue data
				);
				return;
			}
			visitedEntities.add(current);
			current = current.superEntity;
		}
	}

// - Check number of fields which Entity declares:
// 1) If Entity do not extends another entity then it MUST have 1 or more fields!
// 2) If Entity extends another entity then it can have 0 or more fields!
	@Check
	def checkNumberOfEntityFields(TangEntity tangEntity) {
		if (tangEntity.fields.empty) {
			if (tangEntity.superEntity === null) {
				// Entity MUST have at least 1 field!
				error("Entity '"+ tangEntity.name +"' has no fields"
					, TangPackage.Literals.TANG_ENTITY__FIELDS
					, ENTITY_HAS_NO_FIELDS // issue code
					, tangEntity.name // issue data
				);
			}
		}
	}
// - Check is there is duplicated Entity field names in the whole Entity hierarchy!
	@Check
	def checkUniquesOfEntityFieldNames(TangEntity tangEntity) {
		if (tangEntity.superEntity === null) {
			return // Nothing to check
		}
		var visitedFields = newHashSet();
		for (Field currentField : tangEntity.fields) {
			visitedFields.add(currentField.name);
		}
		var currentEntity = tangEntity.superEntity;
		var parentEntity = tangEntity;
		while (currentEntity !== null) {
			for (Field currentField: currentEntity.fields) {
				if (visitedFields.contains(currentField.name)) {
					error("Duplicate field name '"+currentField.name+"' in entity '"+ parentEntity.name +"'"
						, TangPackage.Literals.TANG_ENTITY__FIELDS
						, DUPLICATE_FIELD_NAME // issue code
						, currentField.name    // issue data
					);
					return;
				}
				visitedFields.add(currentField.name);
			}
			parentEntity = currentEntity;
			currentEntity = currentEntity.superEntity;
		}
		
	}


// - Capital letter validations
	@Check
	def checkTypeStartsWithCapital(TangType tangType) {
		if (!Character.isUpperCase(tangType.name.charAt(0))) {
			warning('Name should start with a capital letter'
				, TangPackage.Literals.TANG_ABSTRACT_ELEMENT__NAME
				, INVALID_TYPE_NAME
				, tangType.name // issue data
			)
		}
	}

	@Check
	def checkAbstractElementStartsWithCapital(TangAbstractElement tangAbstractElement) {
		if (!Character.isUpperCase(tangAbstractElement.name.charAt(0))) {
			warning('Name should start with a capital letter'
				, TangPackage.Literals.TANG_ABSTRACT_ELEMENT__NAME
				, INVALID_NAME
				, tangAbstractElement.name // issue data
			)
		}
	}

	@Check
	def checkTabStartsWithCapital(Tab tab) {
		if (!Character.isUpperCase(tab.name.charAt(0))) {
			warning('Tab Name should start with a capital letter'
				, TangPackage.Literals.TAB_ABSTRACT_ELEMENT__NAME
				, INVALID_NAME
				, tab.name // issue data
			)
		}
	}

// - Lower letter validations
	@Check
	def checkFieldStartsWithLower(Field tangField) {
		if (!Character.isLowerCase(tangField.name.charAt(0))) {
			warning('Field Name should start with a lower letter'
				, TangPackage.Literals.FIELD__NAME
				, INVALID_ATTRIBUTE_NAME
				, tangField.name // issue data
			)
		}
	}

	@Check
	def checkEntityViewAliasStartsWithLower(EntityViewAlias entityViewAlias) {
		if (!Character.isLowerCase(entityViewAlias.name.charAt(0))) {
			warning('Alias should start with a lower letter'
				, TangPackage.Literals.ENTITY_VIEW_ALIAS__NAME
				, INVALID_NAME
				, entityViewAlias.name // issue data
			)
		}
	}

	@Check
	def checkEntityViewFieldStartsWithLower(EntityViewField entityViewField) {
		if (!Character.isLowerCase(entityViewField.name.charAt(0))) {
			warning('Field name should start with a lower letter'
				, TangPackage.Literals.ENTITY_VIEW_FIELD__NAME
				, INVALID_NAME
				, entityViewField.name // issue data
			)
		}
	}

}
