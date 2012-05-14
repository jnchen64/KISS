��    �      �  �   l	      �  d   �  )  �  d    �   }  �   \  p   N  J   �  E   
  Q   P  �   �  �   �  �   J  Z   �    R  1   b  #   �  �   �     �     �  #   �  .   �  )   .     X  +   u  *   �  0   �  .   �  0   ,  /   ]  .   �  B   �  /   �  3   /  9   c  1   �  -   �  ?   �  F   =  A   �  >   �  B     6   H  3     7   �  2   �  *     *   I  *   t  /   �     �     �  !   �     !     :     R     j     �     �     �     �     �                 0      I      b      z      �   $   �      �      �      !  !   '!     I!  -   i!     �!  �   �!  1   R"     �"     �"    �"    �#  J  �$  [   &  G  l&     �'  1   �'  3   �'     ,(     <(     L(     h(     �(     �(     �(     �(  %   �(  �   �(  ,   �)     �)  <   *     P*     _*  
   |*     �*     �*     �*     �*     �*  %  �*     ,     +,     9,     E,     a,     y,     �,  
   �,     �,  
   �,  ?   �,  5  �,  �   2.     */  %   3/     Y/     a/     ~/     �/     �/     �/     �/  �  �/  (   X1  �  �1  l   m3  ?   �3  ^  4  �   y5  1   6  0   =6  |   n6  '   �6    7  �   *8  #   �8  D  �8  v   0:    �:  f   �;  )  <  d  <=  �   �?  �   �@  r   rA  J   �A  E   0B  Q   vB  �   �B  �   �C  �   pD  `   E    ~E  2   �F  $   �F     �F     H     H  #   ;H  .   _H  )   �H     �H  +   �H  *   I  0   ,I  .   ]I  0   �I  /   �I  .   �I  B   J  /   _J  3   �J  9   �J  1   �J  -   /K  ?   ]K  F   �K  A   �K  >   &L  B   eL  6   �L  3   �L  7   M  2   KM  *   ~M  *   �M  *   �M  /   �M     /N     GN  !   _N     �N     �N     �N     �N     �N     �N     O     /O     JO     aO     xO     �O     �O     �O     �O     �O  )   P     :P     YP     qP  "   �P     �P  9   �P     	Q  �   Q  -   �Q  	   R     R  I  !R  X  kS  `  �T  �   %V  �  �V     BX  2   UX  =   �X     �X     �X  $   �X  !   Y     2Y     NY     jY     �Y  %   �Y  �   �Y  4   xZ  &   �Z  B   �Z     [  (   &[     O[     \[     s[     �[     �[     �[  B  �[  "   ]     5]     J]     ]]     x]     �]     �]     �]     �]     �]  E   �]  9  (^    b_     w`  .   �`     �`  $   �`     �`     �`     �`     �`     a  �  a  (   �b  *  �b  |   e  >   �e  j  �e  �   Cg  3   �g  2   h  �   Bh  )   �h  8  �h  �   .j  $   �j  �  �j  �   �l     �   +   ~   ?           �   U   F   Q              A       L   6   l       �             w   }          *   �   O       _      q       s      \   $          &   '   a      V   /   �       I   u       1       �   -   .                      �   g       Y   m   x   )       =       C      `   �   v   �                  @       �          P   ]   8      e          J   N   �   S   �   k   H                b       c   !         �   �          5   i   �       B   %   �   �   �   X   z                          p   y      ;   [              f   E   "      <   �           M   �       :           D   G   R   j   W          #   t   4       >   (   K           Z      �   0       2       r   d   7       {   �   3      
      	   h   9   T   n   |   o          ^   ,    
//<replaceable>server</replaceable>/shared /shared cifs credentials=/usr/local/etc/smb-credentials
 
0,10,20,30,40,50 * * * * www-data [ -x /usr/lib/cgi-bin/awstats.pl -a -f /etc/awstats/awstats.conf -a -r /var/log/apache/access.log ] &amp;&amp; /usr/lib/cgi-bin/awstats.pl -config=awstats -update &gt;/dev/null &amp;&amp; /usr/lib/cgi-bin/awstats.pl -config=www.falcot.org -update &gt;/dev/null 
 
<computeroutput>$ </computeroutput><userinput>ldapsearch -x -b dc=falcot,dc=com</userinput>
<computeroutput># extended LDIF
#
# LDAPv3
# base &lt;dc=falcot,dc=com&gt; with scope sub
# filter: (objectclass=*)
# requesting: ALL
#

# falcot.com
dn: dc=falcot,dc=com
objectClass: top
objectClass: dcObject
objectClass: organization
o: Falcot Corp
dc: falcot

# admin, falcot.com
dn: cn=admin,dc=falcot,dc=com
objectClass: simpleSecurityObject
objectClass: organizationalRole
cn: admin
description: LDAP administrator

# search result
search: 2
result: 0 Success

# numResponses: 3
# numEntries: 2
</computeroutput>
 
[netlogon]
comment = Network Logon Service
path = /var/lib/samba/netlogon
guest ok = yes
writable = no
share modes = no

[profiles]
comment = Profile Share
path = /var/lib/samba/profiles
read only = No
profile acls = Yes
 
domain logons = yes              <co id="smb.conf.domainlogons"></co>
preferred master = yes           
logon path = \\%L\profiles\%U    <co id="smb.conf.logonpath"></co>
logon script = scripts/logon.bat <co id="smb.conf.logonscript"></co>
 
mount -t cifs -o credentials=/usr/local/etc/smb-credentials //<replaceable>server</replaceable>/shared /shared
 
net time \\ARRAKIS /set /yes
net use H: /home
net use U: \\ARRAKIS\utils
 
redirect_program /usr/bin/squidGuard -c /etc/squid/squidGuard.conf 
 
smbmount //arrakis/shared /shared -o credentials=/usr/local/etc/smb-credentials
 
smtpd_client_restrictions = permit_mynetworks,
    warn_if_reject reject_unknown_client,
    check_client_access hash:/etc/postfix/access_clientip,
    reject_rbl_client sbl-xbl.spamhaus.org,
    reject_rbl_client list.dsbl.org
 
smtpd_helo_restrictions = permit_mynetworks, reject_invalid_hostname,
    check_helo_access hash:/etc/postfix/access_helo,
    reject_non_fqdn_hostname, warn_if_reject reject_unknown_hostname
 
smtpd_sender_restrictions = 
    check_sender_access hash:/etc/postfix/access_sender,
    reject_unknown_sender_domain, reject_unlisted_sender,
    reject_non_fqdn_sender
 
username = <replaceable>user</replaceable>
password = <replaceable>password</replaceable> #
# LDAP Defaults
#

# See ldap.conf(5) for details
# This file should be world readable but not world writable.

BASE   dc=falcot,dc=com
URI    ldaps://ldap.falcot.com

#SIZELIMIT      12
#TIMELIMIT      15
#DEREF          never

TLS_CACERT /etc/ssl/certs/ldap-cert.pem
 <emphasis>ALTERNATIVE</emphasis> The Exim4 server <emphasis>VOCABULARY</emphasis> ISP <emphasis>nfs-user-server</emphasis> is an NFS server running as a traditional server, with a user-space program and not a kernel module. This version of NFS is mostly obsolete since the kernel-based NFS server is now mature and reliable. <literal>3</literal> <literal>DATA</literal> checks <literal>dc=falcot,dc=com</literal> <literal>http://localhost:631/admin</literal>. <literal>ldap://ldap.falcot.com</literal> <literal>localhost</literal> <primary><command>lockd</command></primary> <primary><command>luma</command></primary> <primary><command>portmapper</command></primary> <primary><command>procmail</command></primary> <primary><command>rpc.mountd</command></primary> <primary><command>rpc.statd</command></primary> <primary><command>smbmount</command></primary> <primary><emphasis role="pkg">apache2-mpm-itk</emphasis></primary> <primary><emphasis>AWStats</emphasis></primary> <primary><emphasis>libpam-ldap</emphasis></primary> <primary><emphasis>nfs-kernel-server</emphasis></primary> <primary><emphasis>smbclient</emphasis></primary> <primary><emphasis>smbfs</emphasis></primary> <primary><filename>/etc/default/nfs-common</filename></primary> <primary><filename>/etc/default/nfs-kernel-server</filename></primary> <primary><filename>/etc/pam.d/common-account</filename></primary> <primary><filename>/etc/pam.d/common-auth</filename></primary> <primary><filename>/etc/pam.d/common-password</filename></primary> <primary><filename>common-account</filename></primary> <primary><filename>common-auth</filename></primary> <primary><filename>common-password</filename></primary> <primary><filename>nfs-common</filename></primary> <primary><literal>DATA</literal></primary> <primary><literal>EHLO</literal></primary> <primary><literal>HELO</literal></primary> <primary><literal>MAIL FROM</literal></primary> <primary>CIFS</primary> <primary>Exim</primary> <primary>HTTP/FTP proxy</primary> <primary>HTTPS</primary> <primary>LDAP</primary> <primary>LDIF</primary> <primary>NFS</primary> <primary>OpenLDAP</primary> <primary>Postfix</primary> <primary>RBL</primary> <primary>RCPT TO</primary> <primary>RPC</primary> <primary>SMB</primary> <primary>SMTP</primary> <primary>Samba</primary> <primary>Squid</primary> <primary>WINS</primary> <primary>alias</primary> <primary>antivirus</primary> <primary>domain controller</primary> <primary>proxy cache</primary> <primary>spam</primary> <primary>spammer</primary> <primary>virtual domain</primary> <primary>virtual host</primary> AWStats configuration file for a virtual host Adding Users After this first step, the administrators got the following configuration file; it will be used as a starting point for adding some extra functionality in the next sections. An administrative passwords needs to be typed in. Answer Apache As with other filesystems, integrating an NFS share into the system hierarchy requires mounting. Since this filesystem has its peculiarities, a few adjustments were required in the syntaxes of the <command>mount</command> command and the <filename>/etc/fstab</filename> file. By default, Apache handles incoming requests under the identity of the <literal>www-data</literal> user. This means that a security vulnerability in a CGI script executed by Apache (for a dynamic page) won't compromise the whole system, but only the files owned by this particular user. By default, the LDAP protocol transits on the network as cleartext; this includes the (encrypted) passwords. Since the encrypted passwords can be extracted from the network, they can be vulnerable to dictionary-type attacks. This can be avoided by using an extra encryption layer; enabling this layer is the topic of this section. Caching: recently downloaded documents are copied locally, which avoids multiple downloads. Changing the standard PAM configuration used by various programs is a sensitive operation. A mistake can lead to broken authentication, which could prevent logging in. Keeping a root shell open is therefore a good precaution. If configuration errors occur, they can be then fixed and the services restarted with minimal effort. Common Directives Configuration of <emphasis>libpam-ldap</emphasis> Configuring <command>slapd</command> for encryption Configuring NSS Configuring PAM Configuring Virtual Domains Configuring Virtual Hosts Configuring a Cache Configuring a Filter Configuring the Client Configuring the Server Does the LDAP database require login? Each SMTP exchange starts with a <literal>HELO</literal> (or <literal>EHLO</literal>) command, followed by the name of the sending email server; checking the validity of this name can be interesting. Enables the domain controller functionality. Enabling content-based filters Example <filename>/etc/postfix/header_checks</filename> file HTTP/FTP Proxy Here are the required steps: Installing Installing Apache Installing Postfix Integrating an Antivirus LDAP Directory LDAP account for root LDAP clients also need to be able to authenticate the server by knowing its public key. This requires installing a copy of the key (for instance as <filename>/etc/ssl/certs/ldap-cert.pem</filename>), and reference the location of this copy in the <filename>/etc/ldap/ldap.conf</filename> file. LDAP root account password Log Analyzers Mail Server Managing Accounts with LDAP Mounting Windows Shares Mounting a Windows share NFS NFS Client NFS File Server NFS Server Now these keys have to be installed in their standard location: On the client side, the configuration for the <emphasis>libpam-ldap</emphasis> and <emphasis>libnss-ldap</emphasis> modules needs to be modified by adding the <literal>ssl on</literal> directive to the <filename>/etc/pam_ldap.conf</filename> and <filename>/etc/libnss-ldap.conf</filename> configuration files. Once the package is installed, the <filename>/etc/migrationtools/migrate_common.ph</filename> must be edited; the <varname>IGNORE_UID_BELOW</varname> and <varname>IGNORE_GID_BELOW</varname> options need to be enabled (uncommenting them is enough). OpenLDAP Organization name: “Falcot Corp”. Postfix Printing on a Shared Printer Question Samba Samba Client Samba Server Squid The <command>mount</command> command itself does not handle CIFS; however, when asked to mount an unknown filesystem type, it tries delegating the task to a <command>mount.<replaceable>type</replaceable></command>. Since the <emphasis role="pkg">smbfs</emphasis> package does provide a <command>mount.cifs</command> command, it then becomes possible to mount a Windows share with the standard <command>mount</command> command: The <command>smbclient</command> Program The <command>smbclient</command> program queries SMB servers. It accepts a <literal>-U <replaceable>user</replaceable></literal> option, for connecting to the server under a specific identity. <command>smbclient //<replaceable>server</replaceable>/<replaceable>share</replaceable></command> accesses the share in an interactive way similar to the command-line FTP client. <command>smbclient -L <replaceable>server</replaceable></command> lists all available (and visible) shares on a server. The <command>smbmount</command> command allows mounting a Windows share into the Linux filesystem hierarchy. The <command>smbumount</command> command unmounts an SMB share. The <emphasis role="pkg">migrationtools</emphasis> package provides a set of scripts dedicated to extract data from the standard Unix directories (<filename>/etc/passwd</filename>, <filename>/etc/group</filename>, <filename>/etc/services</filename>, <filename>/etc/hosts</filename> and so on), convert this data, and inject it into the LDAP database. The <emphasis role="pkg">samba</emphasis> package contains the main two servers of Samba 3, <command>smbd</command> and <command>nmbd</command>. The <filename>/etc/ldap/ldap.conf</filename> file The <filename>/etc/nsswitch.conf</filename> file The <filename>/usr/local/etc/smb-credentials</filename> file (which must not be readable by users) has the following format: The <filename>logon.bat</filename> file This chapter sampled only a fraction of the available server software; however, most of the common network services were described. Now it is time for an even more technical chapter: we'll go into deeper detail for some concepts, describe massive deployments and virtualization. This command creates a certificate in the <filename>newcert.pem</filename> file; the corresponding private key is stored in <filename>newkey.pem</filename>. Voilà, the printer is operational! When a variable contains a list of rules, as in the example above, these rules are evaluated in order, from the first to the last. Each rule can accept the message, reject it, or leave the decision to a following rule. As a consequence, order matters, and simply switching two rules can lead to a widely different behaviour. Yes. This allows using the usual <command>passwd</command> command for changing passwords stored in the LDAP database. Project-Id-Version: 0
POT-Creation-Date: 2012-05-09T20:00:20
PO-Revision-Date: 2012-05-13 10:21+0100
Last-Translator: Isma <isma.deandres@gmail.com>
Language-Team: None
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
 
//<replaceable>servidor</replaceable>/shared /shared cifs credentials=/usr/local/etc/smb-credentials
 
0,10,20,30,40,50 * * * * www-data [ -x /usr/lib/cgi-bin/awstats.pl -a -f /etc/awstats/awstats.conf -a -r /var/log/apache/access.log ] &amp;&amp; /usr/lib/cgi-bin/awstats.pl -config=awstats -update &gt;/dev/null &amp;&amp; /usr/lib/cgi-bin/awstats.pl -config=www.falcot.org -update &gt;/dev/null 
 
<computeroutput>$ </computeroutput><userinput>ldapsearch -x -b dc=falcot,dc=com</userinput>
<computeroutput># extended LDIF
#
# LDAPv3
# base &lt;dc=falcot,dc=com&gt; with scope sub
# filter: (objectclass=*)
# requesting: ALL
#

# falcot.com
dn: dc=falcot,dc=com
objectClass: top
objectClass: dcObject
objectClass: organization
o: Falcot Corp
dc: falcot

# admin, falcot.com
dn: cn=admin,dc=falcot,dc=com
objectClass: simpleSecurityObject
objectClass: organizationalRole
cn: admin
description: LDAP administrator

# search result
search: 2
result: 0 Success

# numResponses: 3
# numEntries: 2
</computeroutput>
 
[netlogon]
comment = Network Logon Service
path = /var/lib/samba/netlogon
guest ok = yes
writable = no
share modes = no

[profiles]
comment = Profile Share
path = /var/lib/samba/profiles
read only = No
profile acls = Yes
 
domain logons = yes              <co id="smb.conf.domainlogons"></co>
preferred master = yes           
logon path = \\%L\profiles\%U    <co id="smb.conf.logonpath"></co>
logon script = scripts/logon.bat <co id="smb.conf.logonscript"></co>
 
mount -t cifs -o credentials=/usr/local/etc/smb-credentials //<replaceable>servidor</replaceable>/shared /shared
 
net time \\ARRAKIS /set /yes
net use H: /home
net use U: \\ARRAKIS\utils
 
redirect_program /usr/bin/squidGuard -c /etc/squid/squidGuard.conf 
 
smbmount //arrakis/shared /shared -o credentials=/usr/local/etc/smb-credentials
 
smtpd_client_restrictions = permit_mynetworks,
    warn_if_reject reject_unknown_client,
    check_client_access hash:/etc/postfix/access_clientip,
    reject_rbl_client sbl-xbl.spamhaus.org,
    reject_rbl_client list.dsbl.org
 
smtpd_helo_restrictions = permit_mynetworks, reject_invalid_hostname,
    check_helo_access hash:/etc/postfix/access_helo,
    reject_non_fqdn_hostname, warn_if_reject reject_unknown_hostname
 
smtpd_sender_restrictions = 
    check_sender_access hash:/etc/postfix/access_sender,
    reject_unknown_sender_domain, reject_unlisted_sender,
    reject_non_fqdn_sender
 
username = <replaceable>usuario</replaceable>
password = <replaceable>contraseña</replaceable> #
# LDAP Defaults
#

# See ldap.conf(5) for details
# This file should be world readable but not world writable.

BASE   dc=falcot,dc=com
URI    ldaps://ldap.falcot.com

#SIZELIMIT      12
#TIMELIMIT      15
#DEREF          never

TLS_CACERT /etc/ssl/certs/ldap-cert.pem
 <emphasis>ALTERNATIVA</emphasis> El servidor Exim4 <emphasis>VOCABULARIO</emphasis> ISP El <emphasis>nfs-user-server</emphasis> es un servidor NFS que se ejecuta en un servidor tradicional, con un programa del espacio-usuario y no un módulo del kernel. Esta versión de NFS es bastante obsoleta ya que ahora el servidor de NFS basado en el kernel está maduro y es confiable. <literal>3</literal> <literal>DATA</literal> checks <literal>dc=falcot,dc=com</literal> <literal>http://localhost:631/admin</literal>. <literal>ldap://ldap.falcot.com</literal> <literal>localhost</literal> <primary><command>lockd</command></primary> <primary><command>luma</command></primary> <primary><command>portmapper</command></primary> <primary><command>procmail</command></primary> <primary><command>rpc.mountd</command></primary> <primary><command>rpc.statd</command></primary> <primary><command>smbmount</command></primary> <primary><emphasis role="pkg">apache2-mpm-itk</emphasis></primary> <primary><emphasis>AWStats</emphasis></primary> <primary><emphasis>libpam-ldap</emphasis></primary> <primary><emphasis>nfs-kernel-server</emphasis></primary> <primary><emphasis>smbclient</emphasis></primary> <primary><emphasis>smbfs</emphasis></primary> <primary><filename>/etc/default/nfs-common</filename></primary> <primary><filename>/etc/default/nfs-kernel-server</filename></primary> <primary><filename>/etc/pam.d/common-account</filename></primary> <primary><filename>/etc/pam.d/common-auth</filename></primary> <primary><filename>/etc/pam.d/common-password</filename></primary> <primary><filename>common-account</filename></primary> <primary><filename>common-auth</filename></primary> <primary><filename>common-password</filename></primary> <primary><filename>nfs-common</filename></primary> <primary><literal>DATA</literal></primary> <primary><literal>EHLO</literal></primary> <primary><literal>HELO</literal></primary> <primary><literal>MAIL FROM</literal></primary> <primary>CIFS</primary> <primary>Exim</primary> <primary>proxy HTTP/FTP</primary> <primary>HTTPS</primary> <primary>LDAP</primary> <primary>LDIF</primary> <primary>NFS</primary> <primary>OpenLDAP</primary> <primary>Postfix</primary> <primary>RBL</primary> <primary>RCPT TO</primary> <primary>RPC</primary> <primary>SMB</primary> <primary>SMTP</primary> <primary>Samba</primary> <primary>Squid</primary> <primary>WINS</primary> <primary>alias</primary> <primary>antivirus</primary> <primary>controlador de dominio</primary> <primary>proxy cache</primary> <primary>spam</primary> <primary>spammer</primary> <primary>dominio virtual</primary> <primary>host virtual</primary> Fichero de configuración de AWStats para un virtual host Añadir Usuarios Después de este paso, los administradores obtenemos el siguiente fichero de configuración; que será usado en las siguientes secciones como punto de partida para añadir alguna funcionalidad extra. La password administrativa debe ser tecleada. Respuesta Apache Como con cualquier otro sistema de ficheros, para incorporar un share de NFS en el jerarquía del sistema es necesario montarlo. Debido a que este sistema de ficheros tiene sus peculiaridades, son necesarios unos pocos ajustes en la sintaxis del comando  <command>mount</command> y en el fichero  <filename>/etc/fstab</filename>. Por defecto, Apache maneja todas las peticiones entrantes bajo la identidad del usuario <literal>www-data</literal>. Esto significa que en caso de una vulnerabilidad de seguridad en un script CGI para Apache (para una página dinámica) no se comprometerá todo el sistema, sino solo los ficheros que son propiedad de ese usuario en particular. Por defecto, el protocolo LDAP se transmite por la red como texto plano; incluyendo las contraseñas (encriptadas). Debido a que se pueden obtener las claves encriptadas de la red, pueden ser vulnerables a ataques de tipo diccionario. Esto puede ser evitado aplicando una capa extra de encriptación; en esta sección trararemos como activar esta capa. Actuar como caché: los documentos que han sido descargados recientemente son copiados localmente, para evitar que vuelvan a tener que ser descargados. El cambio de la configuración estandar de PAM que es usada por varios programas es una operación delicada. Un error puede provocar que fallos de autenticación, lo que podría impedir la entrada en  el sistema. Por lo que se recomienda mantener una consola de root abierta. Si ocurriera cualquier error de configuración, podría ser solucionado y los servicios reiniciados fácilmente. Directivas Comunes Configuración de <emphasis>libpam-ldap</emphasis> Configuración de <command>slapd</command> para encriptación Configurar NSS Configuración de PAM Configuración de Dominios Virtuales Configuración de Hosts Virtuales Configuración de la Caché Configuración de un Filtro Configuración del Cliente Configuración de Servidor La base de datos LDAP requiere login? Cada intercambio SMTP comienza con el comando <literal>HELO</literal> (o <literal>EHLO</literal>), seguido del nombre del servidor que envía el email; es interesante validarlo. Habilita la funcionalidad de controlador de dominio. Habilitar filtros basados en contenido Ejemplo de fichero <filename>/etc/postfix/header_checks</filename> Proxy HTTP/FTP Los pasos necesarios son los siguientes: Instalación Instalación de Apache Instalación de Postfix Integración con un Antivirus Directorio LDAP cuenta LDAP para root Es necesarios que los clientes LDAP también sean capaces de verificar el servidor por medio de su clave pública. Para ello es preciso instalar una copia de la clave (por ejemplo <filename>/etc/ssl/certs/ldap-cert.pem</filename>), y hacer referencia a su ubicación en el fichero <filename>/etc/ldap/ldap.conf</filename>. password de la cuenta root de LDAP Analizadores de Logs Servidor de Correo Gestionar Cuentas con LDAP Montar Shares de Windows Montar un Share de Windows NFS Cliente NFS Servidor de Ficheros NFS Servidor NFS Ahora estas claves deben ser instaladas en su localización estandar: En lado cliente, la configuración de los módulos  <emphasis>libpam-ldap</emphasis> y <emphasis>libnss-ldap</emphasis> necesita ser modificada añadiendo las directiva <literal>ssl on</literal> a los ficheros de configuración <filename>/etc/pam_ldap.conf</filename> y <filename>/etc/libnss-ldap.conf</filename>. Una vez que el paquete ha sido instalado, es necesario editar el fichero <filename>/etc/migrationtools/migrate_common.ph</filename>; las opciones <varname>IGNORE_UID_BELOW</varname> y <varname>IGNORE_GID_BELOW</varname>  deben ser activadas (con descomentarlas es suficiente). OpenLDAP Nombre de la organización: “Falcot Corp”. Postfix Imprimir en una Impresora Compartida Pregunta Samba Cliente Samba Servidor Samba Squid El comando <command>mount</command> no permite por sí mismo manejar CIFS; sin embargo, cuando se le pide que monte un sistema de ficheros desconocido, intenta delegar la tarea a <command>mount.<replaceable>tipo</replaceable></command>. Debido a que el paquete  <emphasis role="pkg">smbfs</emphasis> proporciona el comando <command>mount.cifs</command>, es posible montar un share de Windows con el comando estandar <command>mount</command>: El Programa <command>smbclient</command> El programa <command>smbclient</command> consulta a los servidores SMB. Puede utilizarse la opción <literal>-U <replaceable>usuario</replaceable></literal>, para conectar al servidor bajo una identidad concreta. Con <command>smbclient //<replaceable>servidor</replaceable>/<replaceable>share</replaceable></command> se accede al share de modo interactivo como si se tratara de un cliente FTP de linea de comandos. Con <command>smbclient -L <replaceable>servidor</replaceable></command> se listan todos los shares disponibles (y visibles) en un servidor. El comando <command>smbmount</command> permite montar un share de Windows en la jerarquía del sistema de ficheros de Linux. El comando <command>smbumount</command> desmonta un share SMB. El paquete <emphasis role="pkg">migrationtools</emphasis> proporciona un conjunto de scripts para extraer los datos de los directorios estandar de Unix (<filename>/etc/passwd</filename>, <filename>/etc/group</filename>, <filename>/etc/services</filename>, <filename>/etc/hosts</filename> y otros más), convetir estos datos e inyectarla en la base de datos LDAP. El paquete <emphasis role="pkg">samba</emphasis> contiene los dos servidores principales de Samba 3: <command>smbd</command> y <command>nmbd</command>. El fichero <filename>/etc/ldap/ldap.conf</filename> El fichero <filename>/etc/nsswitch.conf</filename> El fichero <filename>/usr/local/etc/smb-credentials</filename> (que no debe ser accesible por los usuarios ) tiene el siguiente formato: El fichero <filename>logon.bat</filename> Este capítulo solo analiza una parte de todo el software de servidor disponible; sin embargo, se han descrito la mayoría de los servicios de red. Es el momento de un capítulo aún más técnico: profundizaremos en los detalles de algunos conceptos, describiremos los despliegues masivos y la virtualización.  Este comando crea un certificado en el fichero <filename>newcert.pem</filename>; la clave privada correspondiente es almacenada en <filename>newkey.pem</filename>. Voilà, la impresora ya está lista! Cuando la variable contiene una lista de reglas, como en el ejemplo anterior, estas reglas son evaluadas ordenadamente, desde la primera hasta la última. Cada regla puede aceptar el mensaje, rechazarlo o dejar la decisión de qué hacer a posteriores reglas. Por lo tanto, el orden importa, cambiar el orden en el que están establecidas las reglas puede provocar un comportamiento completamente diferente. Sí. Esto permite usar el comando <command>passwd</command> típico para el cambio de las passwords que se encuentran almacenadas en una base de datos LDAP. 