/*
 * generated by Xtext 2.12.0
 */
package net.adempiere.tang.dsl.ui.quickfix

import org.eclipse.xtext.ui.editor.quickfix.DefaultQuickfixProvider
import org.eclipse.xtext.ui.editor.quickfix.Fix
import net.adempiere.tang.dsl.validation.TangValidator
import org.eclipse.xtext.validation.Issue
import org.eclipse.xtext.ui.editor.quickfix.IssueResolutionAcceptor
import net.adempiere.tang.dsl.tang.Field
import net.adempiere.tang.dsl.tang.TangEntity
import org.eclipse.xtext.diagnostics.Diagnostic

import static extension org.eclipse.xtext.EcoreUtil2.*;
import net.adempiere.tang.dsl.tang.TangModule
import net.adempiere.tang.dsl.tang.TangPackage
import net.adempiere.tang.dsl.tang.TangPackageDeclaration
import net.adempiere.tang.dsl.tang.TangFactory

/**
 * Custom quickfixes.
 *
 * See https://www.eclipse.org/Xtext/documentation/310_eclipse_support.html#quick-fixes
 */
// @Trifon
class TangQuickfixProvider extends DefaultQuickfixProvider {

	// This method provides fix by modifying Textual representation
	@Fix(TangValidator.INVALID_TYPE_NAME)
	def capitalizeTypeNameFirstLetter(Issue issue, IssueResolutionAcceptor acceptor) {
		acceptor.accept(issue
			, 'Capitalize first letter'  // label
			, "Capitalize first letter of '" + issue.data.get(0) + "'" // description
			, 'upcase.png' // icon
		) [
			context |
			val xtextDocument = context.xtextDocument
			val firstLetter = xtextDocument.get(issue.offset, 1)
			xtextDocument.replace(issue.offset, 1, firstLetter.toUpperCase)
		]
	}

//----------------------
// EMF Model based fixes
	// This method provides fix by modifying EMF model
	@Fix(TangValidator.INVALID_ATTRIBUTE_NAME)
	def uncapitalizeFieldNameFirstLetter(Issue issue, IssueResolutionAcceptor acceptor) {
		acceptor.accept(issue
			, 'Uncapitalize first letter'  // label
			, "Uncapitalize first letter of '" + issue.data.get(0) + "'" // description
			, 'upcase.png' // icon
		) [
			field, context |
			(field as Field).name = issue.data.get(0).toFirstLower;
		]
	}

	// This method provides fix by modifying EMF model
	@Fix(TangValidator.ENTITY_HIERARCHY_CYCLE)
	def removeSuperType(Issue issue, IssueResolutionAcceptor acceptor) {
		acceptor.accept(issue
			, 'Remove supertype'  // label
			, '''Remove supertype '«issue.data.get(0)»' ''' // description
			, 'delete_obj.png' // icon
		) [
			element, context |
			(element as TangEntity).superEntity = null;
		]
	}


//--------------------------------------------
// Fixes or DEFAULT Validation errors/warnings
	@Fix(Diagnostic.LINKING_DIAGNOSTIC)
	def createMissingEntity(Issue issue, IssueResolutionAcceptor acceptor) {
		acceptor.accept(issue
			, 'Create missing entity'  // label
			, 'Create missing entity' // description
			, 'entity.png' // icon
		) [
			element, context |
			val currentEntity = element.getContainerOfType(TangEntity);
			val tangPackage = currentEntity.eContainer as TangPackageDeclaration;
			tangPackage.elements.add(tangPackage.elements.indexOf(currentEntity) + 1
				, TangFactory.eINSTANCE.createTangEntity() =>
					[
						val newEntityName = context.xtextDocument.get(issue.offset, issue.length);
						name = newEntityName;
						tableName = newEntityName;

						val idField = TangFactory.eINSTANCE.createField() =>
						[
							name = 'id';
//							fieldType = value
							columnName = 'id';
						]

//						val primaryKeyDef = TangFactory.eINSTANCE.createPrimaryKey() =>
//						[
//							name = newEntityName + '_pk';
//							fields.add(idField);
//						]
//						primaryKey = primaryKeyDef;
					]
				);
		]
	}
	
}
