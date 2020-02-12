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
class TangTypeToDbTypeConverter {

	def toDbType(TangAbstractType abstractType) {
		switch (abstractType) {
			TangType case (abstractType instanceof TangType): {
				return toDbType(abstractType);
			}
			TangAbstractEntity case (abstractType instanceof TangAbstractEntity): {
				return toDbType(abstractType);
			}
			default: {
				"TangAbstractType - unknown -- toDbType()"
			}
		}
	}

	def toDbType(TangType type) {
		switch (type) {
			BasicType case (type instanceof BasicType): {
				toDbType(type);
			}
			SubType case (type instanceof SubType): {
				toDbType(type);
			}
			default: {
				"TangType - unknown -- toDbType()"
			}
		}
	}

	def toDbType(TangAbstractEntity abstractEntity) {
		return abstractEntity.name; // old: return "TangAbstractEntity - unknown" + abstractEntity.name;
	//	TangEntity | TangEntityViewNative | TangEntityView
	}
	def toDbTypeOfPrimaryKey(TangAbstractEntity abstractEntity) {
		switch (abstractEntity) {
			TangEntity case (abstractEntity instanceof TangEntity): {
				toDbType(abstractEntity?.primaryKey.fields.get(0).fieldType)
			}
			TangEntityView case (abstractEntity instanceof TangEntityView): {
				Long; // TODO - Hardcoded!!!
			}
			TangEntityViewNative case (abstractEntity instanceof TangEntityViewNative): {
				Long; // TODO - Hardcoded!!!
			}
			default: {
				"TangAbstractEntity - unknown -- toDbType()"
			}
		}
	//	TangEntity | TangEntityViewNative | TangEntityView
	}
	def toDbType(BasicType basicType) {
		switch (basicType) {
			BasicStringType case (basicType instanceof BasicStringType): {basicType.dbType} // "VARCHAR(255)"
			BasicIntegerType case (basicType instanceof BasicIntegerType): {basicType.dbType} // "BIGINT"
			BasicLongType case (basicType instanceof BasicLongType): {basicType.dbType} // "BIGINT"
			BasicDecimalType case (basicType instanceof BasicDecimalType): {basicType.dbType} // "DECIMAL(10,2)"
			BasicBooleanType case (basicType instanceof BasicBooleanType): {basicType.dbType} // "BOOLEAN"
			BasicDateType case (basicType instanceof BasicDateType): {basicType.dbType} // "DATE"
			BasicTimeType case (basicType instanceof BasicTimeType): {basicType.dbType} // "TIMESTAMP"
			BasicDateTimeType case (basicType instanceof BasicDateTimeType): {basicType.dbType} // "TIMESTAMP"
			default: {
				"BasicType - unknown -- toDbType()"
			}
		}
	}
	def toDbType(SubType subType) {
		switch (subType) {
			SubStringType case (subType instanceof SubStringType): {subType.superType.dbType}
			SubIntegerType case (subType instanceof SubIntegerType): {subType.superType.dbType}
			SubLongType case (subType instanceof SubLongType): {subType.superType.dbType}
			SubDecimalType case (subType instanceof SubDecimalType): {subType.superType.dbType}
			SubBooleanType case (subType instanceof SubBooleanType): {subType.superType.dbType}
			SubDateType case (subType instanceof SubDateType): {subType.superType.dbType}
			SubTimeType case (subType instanceof SubTimeType): {subType.superType.dbType}
			SubDateTimeType case (subType instanceof SubDateTimeType): {subType.superType.dbType}
			default: {
				"SubType - unknown -- toDbType()"
			}
		}
	}
}
