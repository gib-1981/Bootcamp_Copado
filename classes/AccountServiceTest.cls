@isTest
private class AccountServiceTest {
    @isTest static void testCreateAccount() {
        // Test successful account creation
        Test.startTest();
        Id accId = AccountService.createAccount('Test Account');
        Test.stopTest();
        System.assertNotEquals(null, accId, 'Account Id should not be null');
        Account acc = [SELECT Id, Name FROM Account WHERE Id = :accId];
        System.assertEquals('Test Account', acc.Name, 'Account name should match');
    }

    @isTest static void testUpdateAccount() {
        // Prepare existing account
        Account acc = new Account(Name = 'Initial Name');
        insert acc;

        // Test successful update
        Test.startTest();
        Boolean result = AccountService.updateAccount(acc.Id, 'Updated Name');
        Test.stopTest();
        System.assertEquals(true, result, 'Update should return true');
        Account updated = [SELECT Id, Name FROM Account WHERE Id = :acc.Id];
        System.assertEquals('Updated Name', updated.Name, 'Name should be updated');
    }

    @isTest static void testGetAccountById() {
        // Prepare account with additional fields
        Account acc = new Account(Name = 'GetTest', AccountNumber = '123', Industry = 'Technology');
        insert acc;

        // Test retrieval of existing account
        Test.startTest();
        Account fetched = AccountService.getAccountById(acc.Id);
        Test.stopTest();
        System.assertNotEquals(null, fetched, 'Fetched account should not be null');
        System.assertEquals(acc.Id, fetched.Id, 'Ids should match');
        System.assertEquals('GetTest', fetched.Name, 'Names should match');
        System.assertEquals('123', fetched.AccountNumber, 'AccountNumber should match');
        System.assertEquals('Technology', fetched.Industry, 'Industry should match');

        // Test retrieval with non-existent Id
        Test.startTest();
        Account nullAcc = AccountService.getAccountById('001000000000000AAA');
        Test.stopTest();
        System.assertEquals(null, nullAcc, 'Should return null for non-existent Id');
    }

    @isTest static void testDeleteAccount() {
        // Prepare account for deletion
        Account acc = new Account(Name = 'ToDelete');
        insert acc;

        // Test successful deletion
        Test.startTest();
        Boolean deleteResult = AccountService.deleteAccount(acc.Id);
        Test.stopTest();
        System.assertEquals(true, deleteResult, 'Delete should return true');
        // Verify deletion
        Integer countAfter = [SELECT COUNT() FROM Account WHERE Id = :acc.Id];
        System.assertEquals(0, countAfter, 'Account should be deleted');

        // Test deletion of non-existent record
        Test.startTest();
        Boolean secondDelete = AccountService.deleteAccount(acc.Id);
        Test.stopTest();
        System.assertEquals(false, secondDelete, 'Deleting again should return false');
    }
}