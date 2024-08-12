/*************************************************************
 * @author : th.kim
 * @date : 2024-05-27
 * @description : 동적 필드 정렬 Util
 * @target : Util
==============================================================
 * Ver          Date            Author          Modification
 * 1.0          2024-05-27      th.kim         Initial Version
**************************************************************/
public class DynamicSortUtil implements Comparable {

    public SObject objSObject;
    public String fieldName;
    public Boolean isASC;
    public Boolean isNumber;

    // Constructor
    public DynamicSortUtil(SObject objSObject, String fieldName, Boolean isASC, Boolean isNumber) {
        // Guard against wrapping a null
        if (objSObject == null) {
            Exception ex = new NullPointerException();
            ex.setMessage('SObject argument cannot be null');
            throw ex;
        }
        this.objSObject = objSObject;
        this.fieldName = fieldName;
        this.isASC = isASC;
        this.isNumber = isNumber;
    }

    /**
     * @author th.kim
     * @description 지정된 필드를 기준으로 SObject 비교
     * @param compareTo
     *
     * @return
     */
    public Integer compareTo(Object compareTo) {
        // Cast argument to DynamicSorter
        DynamicSortUtil compareToObj = (DynamicSortUtil) compareTo;

        // 현재 객체와 비교 객체의 필드 값 GET
        String fieldValue = String.valueOf(objSObject.get(this.fieldName));
        String compareToFieldValue = String.valueOf(compareToObj.objSObject.get(this.fieldName));

        // 비교할 값이 숫자일 때
        if(this.isNumber) {
            Integer intValueA = null;
            Integer intValueB = null;
            try {
                intValueA = Integer.valueOf(fieldValue);
            } catch (Exception e) {
                // 예외 처리
                intValueA = 0;
            }
            try {
                intValueB = Integer.valueOf(compareToFieldValue);
            } catch (Exception e) {
                // 예외 처리
                intValueB = 0;
            }

            // 값 비교하여 반환
            if (intValueA == intValueB) {
                return 0;
            } else if (intValueA < intValueB) {
                return isASC ? -1 : 1;
            } else {
                return isASC ? 1 : -1;
            }
        }
        // 비교할 값이 문자일 때
        else {
            // null 값 처리
            if (fieldValue == null && compareToFieldValue == null) {
                return 0;
            } else if (fieldValue == null) {
                return isASC ? -1 : 1;
            } else if (compareToFieldValue == null) {
                return isASC ? 1 : -1;
            }

            // 필드 값 비교하여 반환
            return isASC ? fieldValue.compareTo(compareToFieldValue) : -fieldValue.compareTo(compareToFieldValue);
        }
    }
}