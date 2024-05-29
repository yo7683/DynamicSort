/*************************************************************
 * @author : th.kim
 * @date : 2024-05-29
 * @description : 리스트 동적 정렬 Util Example
 * @target : 
==============================================================
 * Ver          Date            Author          Modification
 * 1.0          2024-05-29      th.kim         Initial Version
**************************************************************/
public with sharing class DynamicSortExample {

    /**
     * @author th.kim
     * @description AnnualRevenue 기준으로 오름차순 정렬
     * @return 정렬된 Account 리스트
     */
    public static List<Account> exDynamicSort() {
        List<Account> listAcc = new List<Account>{
                new Account(
                        Name = 'Test Account 1',
                        AnnualRevenue = 10
                ),
                new Account(
                        Name = 'Test Account 2',
                        AnnualRevenue = 20
                )
        };
        // DynamicSortUtil 리스트 생성
        List<DynamicSortUtil> listSorter = new List<DynamicSortUtil>();
        for (Account objAcc : listAcc) {
            // 필드명, ASC 정렬 기준
            listSorter.add(new DynamicSortUtil(objAcc, 'AnnualRevenue', true));
        }

        // 리스트 정렬
        listSorter.sort();

        List<Account> listReturn = new List<Account>();
        for (DynamicSortUtil sorter : listSorter) {
            // 정렬된 SObject 리스트 Account 리스트에 추가
            listReturn.add((Account) sorter.objSObject);
        }
        return listReturn;
    }
}