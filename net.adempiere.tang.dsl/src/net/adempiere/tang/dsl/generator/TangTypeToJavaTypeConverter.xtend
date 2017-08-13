package net.adempiere.tang.dsl.generator

import net.adempiere.tang.dsl.tang.TangAbstractType
import net.adempiere.tang.dsl.tang.TangType
import net.adempiere.tang.dsl.tang.BasicType
import net.adempiere.tang.dsl.tang.BasicStringType
import net.adempiere.tang.dsl.tang.BasicBooleanType
import net.adempiere.tang.dsl.tang.SubType
import net.adempiere.tang.dsl.tang.TangAbstractEntity
import net.adempiere.tang.dsl.tang.BasicIntegerType
import net.adempiere.tang.dsl.tang.BasicLongType
import net.adempiere.tang.dsl.tang.BasicDecimalType
import net.adempiere.tang.dsl.tang.BasicDateType
import net.adempiere.tang.dsl.tang.BasicDateTimeType
import net.adempiere.tang.dsl.tang.SubStringType
import net.adempiere.tang.dsl.tang.SubIntegerType
import net.adempiere.tang.dsl.tang.SubLongType
import net.adempiere.tang.dsl.tang.SubDecimalType
import net.adempiere.tang.dsl.tang.SubBooleanType
import net.adempiere.tang.dsl.tang.SubDateType
import net.adempiere.tang.dsl.tang.SubDateTimeType
import net.adempiere.tang.dsl.tang.TangEntity
import net.adempiere.tang.dsl.tang.TangEntityViewNative
import net.adempiere.tang.dsl.tang.TangEntityView

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
				"TangAbstractType - unknown"
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
				"TangType - unknown"
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
				"TangAbstractEntity - unknown"
			}
		}
	//	TangEntity | TangEntityViewNative | TangEntityView
	}

	def toJavaType(BasicType basicType) {
		switch (basicType) {
			BasicStringType case (basicType instanceof BasicStringType): {"String"}
			BasicIntegerType case (basicType instanceof BasicIntegerType): {"Integer"}
			BasicLongType case (basicType instanceof BasicLongType): {"Long"} //{fieldType.javaType}
			BasicDecimalType case (basicType instanceof BasicDecimalType): {"Decimal"}
			BasicBooleanType case (basicType instanceof BasicBooleanType): {"Boolean"}
			BasicDateType case (basicType instanceof BasicDateType): {"Date"}
			BasicDateTimeType case (basicType instanceof BasicDateTimeType): {"DateTime"}
			default: {
				"BasicType - unknown"
			}
		}
	}
	def toJavaType(SubType subType) {
		switch (subType) {
			SubStringType case (subType instanceof SubStringType): {"String"}
			SubIntegerType case (subType instanceof SubIntegerType): {"Integer"}
			SubLongType case (subType instanceof SubLongType): {"Long"} //{fieldType.javaType}
			SubDecimalType case (subType instanceof SubDecimalType): {"Decimal"}
			SubBooleanType case (subType instanceof SubBooleanType): {"Boolean"}
			SubDateType case (subType instanceof SubDateType): {"Date"}
			SubDateTimeType case (subType instanceof SubDateTimeType): {"DateTime"}
			default: {
				"SubType - unknown"
			}
		}
	}
}