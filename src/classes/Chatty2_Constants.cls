public with sharing class Chatty2_Constants {
	
    public static Chatty2_Settings__c ChattySettings;
    public static string ChattyName;
    public static map<id, RecordType> commandRecordTypes;
    public static boolean isExecuting = false;
    
    
    public static Chatty2_Settings__c getChattySettings(){
        
        if (ChattySettings == null){
            ChattySettings = Chatty2_Settings__c.getOrgDefaults();          

            //build default settings
            if (ChattySettings == null){
                id chattyid = [select id from User where LastName = 'Chatter Expert' limit 1].id;               
                Chatty2_Settings__c c2s = new Chatty2_Settings__c();
                c2s.Chatty2_User__c = chattyid;
                insert c2s;
            }               
        }
        return ChattySettings;
    }
    
    public static string getChattyName(){
        
        if (ChattyName == null){
            ChattyName = [select Name from User where id = :ChattySettings.Chatty2_User__c limit 1].Name;
        }
        return ChattyName;
    }

    public static map<id, RecordType> getCommandRecordTypes(){
    	if (commandRecordTypes == null){
            commandRecordTypes = new map<id, RecordType>([select id, Name from RecordType where sobjecttype = 'Command__c']);    		
    	}
    	return commandRecordTypes;
    }
    
    
    
    public class ChattyException extends Exception {}

}