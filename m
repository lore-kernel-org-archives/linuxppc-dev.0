Message-ID: <CA78D1B723D8D411AF0300508BDCF74F01F7E99D@NTCORREO>
From: IGOR LURI <iluri@fagorautomation.es>
To: =?ISO-8859-1?Q?EMBEDDED_LINUXPPC_=28Correo_electr=F3nico=29?= <linuxppc-embedded@lists.linuxppc.org>
Subject: Is it posible to have Ethernet on SCC3 , RS line on SMC1 and USB in
	 host mode?
Date: Wed, 19 May 2004 10:43:56 +0200
MIME-Version: 1.0
Content-Type: text/plain;
	charset=ISO-8859-1
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi all!

We have a custom board based on PowerPC 823 with the folowing configuration:

-	A RS line on SMC1
-	A RS line on SCC2
-	Ethernet on SCC3
-	USB

To have a RS line on SMC1 and  Ethernet on SCC3 working together we have to
install a microcode patch. We have done it and it works fine.

Also, to have USB working as host mode, we have to intall another microcode
patch and we done it and it works fine too.

If we install a microde patch to have working ethernet on SCC3 and RS line
on SMC1, we can´t install the other microcode patch to have USB in host
mode.

Is there any posibility to have ethernet on SCC3 , RS line on SMC1 and USB
in host mode working together?

Is there any microcode patch that solves both problems?

Thanks in advance.

Igor Luri Bravo
Tecnico I+D Software
Fagor Automation S. Coop.
P. O. Box 144
E-20500 Mondragón-Arrasate
Tel. ++34 943 71 92 00 - ++34 943 03 98 00
Fax. ++34 943 79 17 12
www.fagorautomation.com <http://www.fagorautomation.com>

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
