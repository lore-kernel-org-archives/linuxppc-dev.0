Message-ID: <791B3205DB661A42B4BFE5464A7D1D02010E461A@chzugexch01.abatos.com>
From: Graf Alex <alex.graf@siemens.com>
To: linuxppc-embedded@lists.linuxppc.org
Subject: AW: Serial Console at MPC8xx SCC1?
Date: Thu, 14 Aug 2003 11:30:53 +0200
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Yes this works very well!
Be sure you have defined CONFIG_SERIAL_CONSOLE_PORT for your uart.c! If you
use SMC1+2 for uarts, define it as 2!

cheers

alex


-----Ursprüngliche Nachricht-----
Von: Steven Scholz [mailto:steven.scholz@imc-berlin.de]
Gesendet: Mittwoch, 13. August 2003 17:25
An: linuxppc-embedded@lists.linuxppc.org
Betreff: Serial Console at MPC8xx SCC1?



Hi there,

has anyone successfully used MPC8xx SCC1 as serial console for Linux?

I am using SMC1 and it works well.
SCC1 is working under U-Boot. But not with linux-2.4.20...

Thanks,

Steven


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
