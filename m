Return-Path: <frannk_m1@yahoo.com>
Received: from web13826.mail.yahoo.com (web13826.mail.yahoo.com
	[66.163.176.58]) by ozlabs.org (Postfix) with SMTP id 86DD22BC0F
	for <linuxppc-embedded@ozlabs.org>;
	Fri,  1 Oct 2004 03:01:53 +1000 (EST)
Message-ID: <20040930165511.61100.qmail@web13826.mail.yahoo.com>
Date: Thu, 30 Sep 2004 09:55:11 -0700 (PDT)
From: Frank <frannk_m1@yahoo.com>
To: linuxppc-embedded@ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Subject: ISA interrupt  problems
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

I am having problems getting the ISA interrupts working when I
cascade the 8259 irq handler to an 8245 external interrupt. I
have the ethernet and serial interrupts working but when I try
to setup the ISA interrupts it either doesn't work or it hangs
when I boot the kernel. Are there any howto's floating around on
setting up the 8259 interrupts. I see a couple of other
platforms (i.e., sandpoint) that are using the ISA interrupts
but it looks likje the have the physical interrupt line
connected to irq 0. I have mine physically connected to external
irq 2. Should it be connected to irq 0 instead?
BTW, I have my Ali1535 superio connected to the external irq 2
of the mpc8245.
Any help would be _greatly_ appreciated...


		
_______________________________
Do you Yahoo!?
Declare Yourself - Register online to vote today!
http://vote.yahoo.com
