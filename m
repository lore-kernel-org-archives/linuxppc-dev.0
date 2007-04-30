Return-Path: <mamsadegh@hotmail.com>
Received: from bay0-omc2-s35.bay0.hotmail.com (bay0-omc2-s35.bay0.hotmail.com
	[65.54.246.171]) by ozlabs.org (Postfix) with ESMTP id C10E2DDF6C
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 30 Apr 2007 16:43:53 +1000 (EST)
Message-ID: <BAY115-W11DBD14D233C8E1FE8CAD3B24C0@phx.gbl>
From: Mohammad Sadegh Sadri <mamsadegh@hotmail.com>
To: Linux PPC Linux PPC <linuxppc-embedded@ozlabs.org>
Subject: I always encouter this simple error message compiling 2.6 for ML403
	UART 16550
Date: Mon, 30 Apr 2007 06:43:49 +0000
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


Well

Don't know if any change should occure in the source files but when I compi=
le any version of 2.6 kernel for ml403/405 with UART 16550 support , I enco=
unter this error message :

arch/ppc/syslib/virtex_devices.c: In function 'virtex_early_serial_init':
arch/ppc/syslib/virtex_devices.c:309: warning: implicit declaration of func=
tion 'gen550_init'
  CC      arch/ppc/syslib/ppc4xx_setup.o
  CC      arch/ppc/syslib/gen550_dbg.o
arch/ppc/syslib/gen550_dbg.c:34: error: 'RS_TABLE_SIZE' undeclared here (no=
t in a function)
arch/ppc/syslib/gen550_dbg.c:36: error: empty scalar initializer
arch/ppc/syslib/gen550_dbg.c:36: error: (near initialization for 'rs_table'=
)
make[1]: *** [arch/ppc/syslib/gen550_dbg.o] Error 1
make: *** [arch/ppc/syslib] Error 2

And for the solution I simply add the following line to the header of gen55=
0_dbg.c :

#include=20

Is there any thing I have missed? or this include line should be added to t=
he source codes?

thanks.
_________________________________________________________________
Connect to the next generation of MSN Messenger=A0
http://imagine-msn.com/messenger/launch80/default.aspx?locale=3Den-us&sourc=
e=3Dwlmailtagline=
