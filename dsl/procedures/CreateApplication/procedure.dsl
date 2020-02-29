// This procedure.dsl was generated automatically
// DO NOT EDIT THIS BLOCK === procedure_autogen starts ===
procedure 'Create Application', description: '''Create a new application.''', {

    step 'Create Application', {
        description = ''
        command = new File(pluginDir, "dsl/procedures/CreateApplication/steps/CreateApplication.pl").text
        shell = 'ec-perl'
        shell = 'ec-perl'

        postProcessor = '''$[/myProject/perl/postpLoader]'''
    }

    formalOutputParameter 'restResult',
        description: 'Rest Call Result'
// DO NOT EDIT THIS BLOCK === procedure_autogen ends, checksum: db4ae73bc0a799e3b0d5b2bb8276b6ee ===
// Do not update the code above the line
// procedure properties declaration can be placed in here, like
// property 'property name', value: "value"
}