# Powershell Scripting

SysAdmin security focused scripts //// Scripts de SysAdmin com foco em segurança


CFG_script.ps1 :  
                 - Download e Extração do Sysmon juntamente com as configurações usadas (SwiftonSecurity) // Download+Extract Sysmon and the required config  
                 - Instalação do Sysmon e aplicação da configuração // Install Sysmon and apply the SwiftonSecurity configuration to the events  
                 - Liga o Windows Remote Management Service e executando a quickconfig // Turn on WRM and executes the quickconfig  
                 - Liga o Windows Event Collector e seta para iniciar quando o Windows iniciar  // Turn on WEC and sets to initialize when the OS does  
                 - Executar com o comando > powershell.exe -executionpolicy remotesigned -File CFG_script.ps1
