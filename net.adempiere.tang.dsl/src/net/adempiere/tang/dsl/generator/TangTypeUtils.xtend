package net.adempiere.tang.dsl.generator

import net.adempiere.tang.dsl.tang.BasicBooleanType
import net.adempiere.tang.dsl.tang.BasicDateTimeType
import net.adempiere.tang.dsl.tang.BasicDateType
import net.adempiere.tang.dsl.tang.BasicDecimalType
import net.adempiere.tang.dsl.tang.BasicIntegerType
import net.adempiere.tang.dsl.tang.BasicLongType
import net.adempiere.tang.dsl.tang.BasicStringType
import net.adempiere.tang.dsl.tang.BasicTimeType
import net.adempiere.tang.dsl.tang.BasicType
import net.adempiere.tang.dsl.tang.SubBooleanType
import net.adempiere.tang.dsl.tang.SubDateTimeType
import net.adempiere.tang.dsl.tang.SubDateType
import net.adempiere.tang.dsl.tang.SubDecimalType
import net.adempiere.tang.dsl.tang.SubIntegerType
import net.adempiere.tang.dsl.tang.SubLongType
import net.adempiere.tang.dsl.tang.SubStringType
import net.adempiere.tang.dsl.tang.SubTimeType
import net.adempiere.tang.dsl.tang.SubType

// @Trifon
public class TangTypeUtils {

	def extractDefaultValue(BasicType basicType) {
		switch (basicType) {
			BasicStringType case (basicType instanceof BasicStringType): {basicType.defaultValue}

			BasicIntegerType case (basicType instanceof BasicIntegerType): {basicType.defaultValue}
			BasicLongType case (basicType instanceof BasicLongType): {basicType.defaultValue}
			BasicDecimalType case (basicType instanceof BasicDecimalType): {basicType.defaultValue}

			BasicBooleanType case (basicType instanceof BasicBooleanType): {basicType.defaultValue}

			BasicDateType case (basicType instanceof BasicDateType): {basicType.defaultValue}
			BasicTimeType case (basicType instanceof BasicTimeType): {basicType.defaultValue}
			BasicDateTimeType case (basicType instanceof BasicDateTimeType): {basicType.defaultValue}
			default: {
				"BasicType - unknown -- extractDefaultValue()"
			}
		}
	}
	def extractDefaultValue(SubType subType) {
		switch (subType) {
			SubStringType case (subType instanceof SubStringType): {
				if (subType.defaultValue !== null) {
					return subType.defaultValue;
				} else {
					return subType.superType.defaultValue
				}
			}

			SubIntegerType case (subType instanceof SubIntegerType): {
				if (subType.defaultValue > -100) { // Integer.MIN_VALUE
					return subType.defaultValue;
				} else {
					return subType.superType.defaultValue
				}
			}
			SubLongType case (subType instanceof SubLongType): {
				if (subType.defaultValue !== null) {
					return subType.defaultValue;
				} else {
					return subType.superType.defaultValue
				}
			}
			SubDecimalType case (subType instanceof SubDecimalType): {
				subType.defaultValue
			}

			SubBooleanType case (subType instanceof SubBooleanType): {
				if (subType.defaultValue == true) {
					return true;
				} else {
					return subType.superType.isDefaultValue
				}
			}

			SubDateType case (subType instanceof SubDateType): {
				if (subType.defaultValue !== null) {
					return subType.defaultValue;
				} else {
					return subType.superType.defaultValue
				}
			}
			SubTimeType case (subType instanceof SubTimeType): {
				if (subType.defaultValue !== null) {
					return subType.defaultValue;
				} else {
					return subType.superType.defaultValue
				}
			}
			SubDateTimeType case (subType instanceof SubDateTimeType): {
				if (subType.defaultValue !== null) {
					return subType.defaultValue;
				} else {
					return subType.superType.defaultValue
				}
			}
			default: {
				"SubType - unknown -- extractDefaultValue()"
			}
		}
	}
}
