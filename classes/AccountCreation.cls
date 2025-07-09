public class AccountCreation {

    /**
     * Creates a new Account record with the given name.
     *
     * @param accountName The name of the account to create.
     * @return The newly created Account record, or null if an error occurred.
     */
    public static Account insertNewAccount(String accountName) {
        // Check if the account name is empty.
        if (String.isBlank(accountName)) {
            // Return null if the account name is empty.
            return null;
        }

        // Create a new Account object.
        Account newAccount = new Account(Name = accountName);

        try {
            // Insert the new account.
            insert newAccount;
            // Return the newly created account.
            return newAccount;
        } catch (DmlException e) {
            // Handle any DML exceptions that may occur.
            // You can log the error or perform other error handling here.
            System.debug('Error creating account: ' + e.getMessage());
            // Return null to indicate an error.
            return null;
        }
    }
}