Return-Path: <ibookdebian@gmail.com>
Received: from rproxy.gmail.com (rproxy.gmail.com [64.233.170.194])
	by ozlabs.org (Postfix) with ESMTP id 3BA1967A95
	for <linuxppc-dev@ozlabs.org>; Mon, 24 Jan 2005 21:52:05 +1100 (EST)
Received: by rproxy.gmail.com with SMTP id i8so448298rne
	for <linuxppc-dev@ozlabs.org>; Mon, 24 Jan 2005 02:52:04 -0800 (PST)
Message-ID: <6ecd913805012402451b425320@mail.gmail.com>
Date: Mon, 24 Jan 2005 11:45:24 +0100
From: David Medina <ibookdebian@gmail.com>
To: linuxppc-dev@ozlabs.org
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Subject: Java/eclipse in PPC
Reply-To: David Medina <ibookdebian@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

en_EN: Hello list,
es_ES: Hola lista,

en_EN: I have a Ibook G4 (the last - 23.01.05) where are installed
Debian Ubuntu 4.01 to PPC (logical)
es_ES: Dispongo de un Ibook G4 (el ultimo - 23.01.05) donde corre una
Debian ubuntu 4.01 para ppc (logicamente).

en_EN: I want to install Java and Eclipse to development. The SDK of
Java is "easy" because can be downloaded to www.ibm.com the version
"1.4.2 SR1"
es_ES: Desearia instalar Java y Eclipse para desarrollo. El SDK de
java esta "sencillo" debido a que se puede descargar facilmente de
www.ibm.com la version "1.4.2 SR1"

en_EN: But... How i can install eclipse IDE?=BF
es_ES: Pero... el eclipse como puedo conseguirlo?=BF.

en_EN: I search in Google and have find two solutions:
es_ES: Desde luego no pregunto sin antes ir a San Google, y este me ha
mostrado dos opciones:

en_EN: 1. Compiling since source code:
es_ES: 1. Compilarlo desde las fuentes descrito en:
http://download.eclipse.org/downloads/drops/R-3.0.1-200409161125/srcInclude=
dBuildInstructions.html

en_EN: Compiling only specific parts of eclipse x86
es_ES: 2. Compilar partes expecificas desde la version oficial del
eclipse x86 descrito en:
http://www.rexi.org/linux/eclipse-ppc.html

en_EN: In the first option, this is the output error:
es_ES: En la primera opcion obtengo este error al hacer el "build -os
...."

JVMDG217: Dump Handler is Processing Signal 4 - Please Wait.
JVMDG303: JVM Requesting Java core file
JVMDG304: Java core file written to
/home/frodo/eclipse_src/javacore.20050123.123151.6641.txt
JVMDG215: Dump Handler has Processed Exception Signal 4.
./build: line 60:  6641 Instrucci=F3n ilegal      ant -buildfile
build.xml $target -DinstallOs=3D$os -DinstallWs=3D$ws -DinstallArch=3D$arch
-Dbootclasspath=3D$bootclasspath -DjavacTarget=3D1.2

en_EN: In the second option where recompiling SWT don=B4t create the 3
.so (only libswt-gtk-3036-so) and although continue with the process
and eclipse executable was created, where i start eclipse only can see
bootsplash before that the output error was:
es_ES: En la segunda opcion al recompilar SWT no se crean los 3 .so
(solo libswt-gtk-3036.so) y aunque siga con el proceso y se cree el
ejecutable eclipse, al iniciarlo solo se muestra el bootsplash antes
de dar el error:

JVMDG217: Dump Handler is Processing Signal 4 - Please Wait.
JVMDG303: JVM Requesting Java core file
JVMDG304: Java core file written to
/home/frodo/eclipse/javacore.20050123.123452.6704.txt
JVMDG215: Dump Handler has Processed Exception Signal 4.

en_EN: I think that the error is in SDK of ibm.com :(. Can i find the
solution?=BF
es_ES: No tengo muchas esperanzas en que alguien encuentre solucion,
porque creo que el error esta en el SDK de ibm.com.

en_EN: Bye and thanks
es_ES: Agradeceria todo tipo de ayuda. SALUDOS ;)
