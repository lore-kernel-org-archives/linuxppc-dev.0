Date: Thu, 24 Jun 2004 18:08:39 +0200
From: Massimiliano Zilio <massimiliano.z@tiscali.it>
Subject: ppc 405 registers init
To: linuxppc-embedded@lists.linuxppc.org
Message-id: <40DAFC87.6030406@tiscali.it>
MIME-version: 1.0
Content-type: text/plain;
	charset=ISO-8859-1;
	format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi,
    I'd like to debug an application that permit me to write the
bootloader image in flash.
I am using PPC405 Gnu tools and Wiggler DBI.

I know that I can set registers value with the command
set reg $r0 0x0  (for example)
but I don't know the relation between gdb reg names and ppc name.
What is the ppc name of r5?  (for example)
What is the gdb name of GPTC?  (for example)

Where can I find these info and the init values of the register?

Thank you very much.

Bye Max


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
