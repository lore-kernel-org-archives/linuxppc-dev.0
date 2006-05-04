Return-Path: <jonandia@aotek.es>
Received: from correo2.sarenet.es (correo2.sarenet.es [194.30.0.12])
	by ozlabs.org (Postfix) with ESMTP id 63FFF67B15
	for <linuxppc-embedded@ozlabs.org>;
	Thu,  4 May 2006 17:43:42 +1000 (EST)
Received: from ntvir (unknown [212.81.206.17])
	by correo2.sarenet.es (Postfix) with ESMTP id A567E36DB7
	for <linuxppc-embedded@ozlabs.org>;
	Thu,  4 May 2006 09:17:21 +0200 (CEST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset=iso-8859-1
Subject: RE: Where to look for CRAMFS
Date: Thu, 4 May 2006 09:17:20 +0200
Message-ID: <918EB199DDDFFA42BEA2EB3A1C6021F38746E2@correo.fagorautomation.net>
From: "Josu Onandia" <jonandia@aotek.es>
To: "Sauro Salomoni" <sauros@gmail.com>,
	<linuxppc-embedded@ozlabs.org>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi Sauro,

You don't tell us what method and bootloader you use.

In case you use uBoot, you should read

http://www.denx.de/wiki/view/DULG/UBootCmdGroupExec#Section_5.9.4.2.

and

http://www.denx.de/wiki/view/DULG/FlashFilesystemsCRAMFS

Actually, I'd suggest reading the whole DULG even if you don't use =
uBoot. It's a very interesting reading.

Good luck

Josu


-----Mensaje original-----
De: linuxppc-embedded-bounces+jonandia=3Daotek.es@ozlabs.org
[mailto:linuxppc-embedded-bounces+jonandia=3Daotek.es@ozlabs.org]En =
nombre
de Sauro Salomoni
Enviado el: mi=E9rcoles, 03 de mayo de 2006 23:15
Para: linuxppc-embedded@ozlabs.org
Asunto: Where to look for CRAMFS


Greetings.

I have an embedded board using i.MX21.

What I want to know is: how do I tell the kernel where my CRAMFS root
file system is?
I mean, I put it in a specific memory address, but how does the kernel
know where it is?!

What happens here is that the kernel looks in some address and don't
find the Magic Number CRAMFS stores in its own start address. I have a
"bad magic number" msg because my root fs is somewhere else.
Can anyone help me, plz?

Thanks in advance.


Sauro
Engineer
Z Tec
www.ztec.com.br
+55 61 3322-2544
_______________________________________________
Linuxppc-embedded mailing list
Linuxppc-embedded@ozlabs.org
https://ozlabs.org/mailman/listinfo/linuxppc-embedded
