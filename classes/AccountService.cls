public class AccountService {

    // Method to create a new Account
    public static Id createAccount(String accountName) {
        Account newAccount = new Account(Name = accountName);
        try {
            insert newAccount;
            return newAccount.Id;
        } catch (Exception e) {
            // Consider logging specific error details here using a logging framework,
            // rather than System.debug, if needed for detailed troubleshooting
            System.debug('Error creating account: ' + e.getMessage()); //Minimal logging for exceptional cases
            return null;
        }
    }

    // Method to update an existing Account
    public static boolean updateAccount(Id accountId, String newName) {
        Account existingAccount = [SELECT Id, Name FROM Account WHERE Id = :accountId];
        if (existingAccount != null) {
            existingAccount.Name = newName;
            try {
                update existingAccount;
                return true;
            } catch (Exception e) {
                System.debug('Error updating account: ' + e.getMessage()); //Minimal logging for exceptional cases
                return false;
            }
        } else {
            return false; //Account not found
        }
    }

    // Method to retrieve an Account by Id
    public static Account getAccountById(Id accountId) {
        try {
           return [SELECT Id, Name, AccountNumber, Industry FROM Account WHERE Id = :accountId];
        } catch(Exception e) {
           System.debug('Error retrieving account: ' + e.getMessage()); //Minimal logging for exceptional cases
           return null;
        }
    }

    // Method to delete an Account
    public static boolean deleteAccount(Id accountId) {
        try {
            Account accountToDelete = new Account(Id = accountId);
            delete accountToDelete;
            return true;
        } catch (Exception e) {
             System.debug('Error deleting account: ' + e.getMessage()); //Minimal logging for exceptional cases
             return false;
        }
    }
}