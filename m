Message-ID: <2F67A63DFFB1D31185D90090278CBB2D014ECAAE@apmail6.chn.agilent.com>
From: "ZHANG,HAI-TAO (Non-A-China,ex1)" <hai-tao_zhang@non.agilent.com>
To: linuxppc-embedded@lists.linuxppc.org
Subject: IDE on Sandpoint
Date: Mon, 4 Sep 2000 11:33:14 +0800 
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi,

I have tried to boot Linux kernel on Sandpoint 603e using the nfsroot. But I
cannot make the IDE working under Mode 1.

There are some comments from MontaVista CDK1.2:
"5) If you want to try IDE, you must route the IDE interrupts through the
i8259; they are not wired to PCI slots 1 & 2 as the Sandpoint manual
indicates."

In the Winbond 83c553 manual, there are some registers that can route the
IDE IRQ into 8259 (IRQ14). I have tried to set them but it does not work, do
I need to modify the hardware? or someone has the successful experience on
IDE disk who can help me?

Thanks a lot,
Haitao Zhang,


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
