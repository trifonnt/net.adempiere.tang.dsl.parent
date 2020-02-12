package net.adempiere.tang.dsl.generator

// @Trifon
class StringUtils {

	def String removeQuotes(String str) {
		var result = str;
		if (str === null) {
			return null;
		} else {
			if (result.startsWith("\"") || result.startsWith("'")) {
				result = result.substring(1);
			}
			if (result.endsWith("\"") || result.endsWith("'")) {
				result = result.substring(0, result.length - 1)
			}

			return result;
		}
	}

}
