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
import net.adempiere.tang.dsl.tang.TangType

// @Trifon
public class IsQuotationMarkRequiredDecisionMaker {

	def isQuotationMarkRequired(TangAbstractType abstractType) {
		switch (abstractType) {
			TangType case (abstractType instanceof TangType): {
				return isQuotationMarkRequired(abstractType);
			}
			TangAbstractEntity case (abstractType instanceof TangAbstractEntity): {
				return isQuotationMarkRequired(abstractType);
			}
			default: {
				false; //"TangAbstractType - unknown -- isString()"
			}
		}
	}

	def isQuotationMarkRequired(TangType type) {
		switch (type) {
			BasicType case (type instanceof BasicType): {
				isQuotationMarkRequired(type);
			}
			SubType case (type instanceof SubType): {
				isQuotationMarkRequired(type);
			}
			default: {
				false; //"TangType - unknown -- isString()"
			}
		}
	}

	def isQuotationMarkRequired(TangAbstractEntity abstractEntity) {
		return false;// abstractEntity.name;
	}
/*
	def toDbTypeOfPrimaryKey(TangAbstractEntity abstractEntity) {
		switch (abstractEntity) {
			TangEntity case (abstractEntity instanceof TangEntity): {
				isQuotationMarkRequired(abstractEntity?.primaryKey.fields.get(0).fieldType)
			}
			TangEntityView case (abstractEntity instanceof TangEntityView): {
				false; // TODO - Hardcoded!!!
			}
			TangEntityViewNative case (abstractEntity instanceof TangEntityViewNative): {
				false; // TODO - Hardcoded!!!
			}
			default: {
				"TangAbstractEntity - unknown -- isString()"
			}
		}
	//	TangEntity | TangEntityViewNative | TangEntityView
	}
*/
	def isQuotationMarkRequired(BasicType basicType) {
		switch (basicType) {
			BasicStringType case (basicType instanceof BasicStringType): {true}

			BasicIntegerType case (basicType instanceof BasicIntegerType): {false}
			BasicLongType case (basicType instanceof BasicLongType): {false}
			BasicDecimalType case (basicType instanceof BasicDecimalType): {false}

			BasicBooleanType case (basicType instanceof BasicBooleanType): {false}

			BasicDateType case (basicType instanceof BasicDateType): {true}
			BasicTimeType case (basicType instanceof BasicTimeType): {true}
			BasicDateTimeType case (basicType instanceof BasicDateTimeType): {true}
			default: {
				false; //"BasicType - unknown -- isString()"
			}
		}
	}
	def isQuotationMarkRequired(SubType subType) {
		switch (subType) {
			SubStringType case (subType instanceof SubStringType): {true}

			SubIntegerType case (subType instanceof SubIntegerType): {false}
			SubLongType case (subType instanceof SubLongType): {false}
			SubDecimalType case (subType instanceof SubDecimalType): {false}

			SubBooleanType case (subType instanceof SubBooleanType): {false}

			SubDateType case (subType instanceof SubDateType): {true}
			SubTimeType case (subType instanceof SubTimeType): {true}
			SubDateTimeType case (subType instanceof SubDateTimeType): {true}
			default: {
				false; //"SubType - unknown -- toDbType()"
			}
		}
	}
}
