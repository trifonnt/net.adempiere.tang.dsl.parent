package net.adempiere.tang.dsl.generator

import org.eclipse.xtext.generator.OutputConfigurationProvider

// @Trifon - change default folder of generated TANG files!
class TangOutputConfigurationProvider extends OutputConfigurationProvider {

	public static val TANG_GEN_FOLDER = "./tang-gen";

	override getOutputConfigurations() {
		super.getOutputConfigurations() => [
			head.outputDirectory = TANG_GEN_FOLDER;
		]
	}
}