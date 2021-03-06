/*
 * generated by Xtext 2.12.0
 */
package net.adempiere.tang.dsl.ui.wizard


import com.google.inject.Inject
import org.eclipse.xtext.generator.IFileSystemAccess2
import org.eclipse.xtext.resource.FileExtensionProvider

class TangNewProjectWizardInitialContents {
	@Inject
	FileExtensionProvider fileExtensionProvider

	def generateInitialContents(IFileSystemAccess2 fsa) {
		fsa.generateFile(
			// @Trifon
			"src/model/ExampleTangModel." + fileExtensionProvider.primaryFileExtension,
			'''
			package net.adempiere.tang.example {
			
				integer-type Integer { java-type="Integer" max-digits=10 allow-null=false }

				entity ExampleEntity db-table-name="example" {
					id: Integer db-column-name="id";

					primary-key base_pk {id}
				}
			}

			'''
			)
	}
}
