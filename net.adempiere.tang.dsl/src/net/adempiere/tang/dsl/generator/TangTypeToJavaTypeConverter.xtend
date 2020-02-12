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
import net.adempiere.tang.dsl.tang.TangAbstractEntity
import net.adempiere.tang.dsl.tang.TangAbstractType
import net.adempiere.tang.dsl.tang.TangEntity
import net.adempiere.tang.dsl.tang.TangEntityView
import net.adempiere.tang.dsl.tang.TangEntityViewNative
import net.adempiere.tang.dsl.tang.TangType

// @Trifon
class TangTypeToJavaTypeConverter {

	def toJavaType(TangAbstractType abstractType) {
		switch (abstractType) {
			TangType case (abstractType instanceof TangType): {
				return toJavaType(abstractType);
			}
			TangAbstractEntity case (abstractType instanceof TangAbstractEntity): {
				return toJavaType(abstractType);
			}
			default: {
				"TangAbstractType - unknown -- toJavaType()"
			}
		}
	}

	def toJavaType(TangType type) {
		switch (type) {
			BasicType case (type instanceof BasicType): {
				toJavaType(type);
			}
			SubType case (type instanceof SubType): {
				toJavaType(type);
			}
			default: {
				"TangType - unknown -- toJavaType()"
			}
		}
	}

	def toJavaType(TangAbstractEntity abstractEntity) {
		return abstractEntity.name; // old: return "TangAbstractEntity - unknown" + abstractEntity.name;
	//	TangEntity | TangEntityViewNative | TangEntityView
	}
	def toJavaTypeOfPrimaryKey(TangAbstractEntity abstractEntity) {
		switch (abstractEntity) {
			TangEntity case (abstractEntity instanceof TangEntity): {
				toJavaType(abstractEntity?.primaryKey.fields.get(0).fieldType)
			}
			TangEntityView case (abstractEntity instanceof TangEntityView): {
				"Long"; // TODO - Hardcoded!!!
			}
			TangEntityViewNative case (abstractEntity instanceof TangEntityViewNative): {
				"Long"; // TODO - Hardcoded!!!
			}
			default: {
				"TangAbstractEntity - unknown -- toJavaType()"
			}
		}
	//	TangEntity | TangEntityViewNative | TangEntityView
	}
	def toJavaType(BasicType basicType) {
		switch (basicType) {
			BasicStringType case (basicType instanceof BasicStringType): {basicType.javaType}
			BasicIntegerType case (basicType instanceof BasicIntegerType): {basicType.javaType}
			BasicLongType case (basicType instanceof BasicLongType): {basicType.javaType}
			BasicDecimalType case (basicType instanceof BasicDecimalType): {basicType.javaType}
			BasicBooleanType case (basicType instanceof BasicBooleanType): {basicType.javaType}
			BasicDateType case (basicType instanceof BasicDateType): {basicType.javaType}
			BasicTimeType case (basicType instanceof BasicTimeType): {basicType.javaType}
			BasicDateTimeType case (basicType instanceof BasicDateTimeType): {basicType.javaType}
			default: {
				"BasicType - unknown -- toJavaType()"
			}
		}
	}
	def toJavaType(SubType subType) {
		switch (subType) {
			SubStringType case (subType instanceof SubStringType): {subType.superType.javaType} // String
			SubIntegerType case (subType instanceof SubIntegerType): {subType.superType.javaType} // Integer
			SubLongType case (subType instanceof SubLongType): {subType.superType.javaType} // Long
			SubDecimalType case (subType instanceof SubDecimalType): {subType.superType.javaType} // BigDecimal
			SubBooleanType case (subType instanceof SubBooleanType): {subType.superType.javaType} // Boolean
			SubDateType case (subType instanceof SubDateType): {subType.superType.javaType} // Date
			SubTimeType case (subType instanceof SubTimeType): {subType.superType.javaType} // Instant
			SubDateTimeType case (subType instanceof SubDateTimeType): {subType.superType.javaType} // Instant
			default: {
				"SubType - unknown -- toJavaType()"
			}
		}
	}
}
