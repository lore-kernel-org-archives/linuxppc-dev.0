Message-ID: <20010622172247.98937.qmail@web12003.mail.yahoo.com>
Date: Fri, 22 Jun 2001 10:22:47 -0700 (PDT)
From: Dinesh Dharmaraju <ddharmaraju@yahoo.com>
Subject: DSP card and linux
To: linuxppc-embedded@lists.linuxppc.org
Cc: ddharmaraju@yahoo.com
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi,
 We have a TMS320C6201 EVM (Evaluation module) board,
which sits on the PCI interface of a host PC. We are
planning to use that as a network interface card
(NIC)on a linux system. So, we'll have to write a
network device driver for that. To develop code for
the TI DSP, we are using code composer, which is a
windows based software.
 We are planning to have a machine set up in dual boot
in windows and linux. The code development for the DSP
would be done on windows. The code would be downloaded
onto the DSP and then, we would boot the host PC in
Linux. The DSP EVM card would then act as a NIC.

 The host PC CPU is intel x386. Though the mail may be
out of place here, I am hoping to get some insights.

 The code composer tool writes into the RAM of the
DSP. So, when the rebooting of the PC happens, the
code gets removed. Are there any loaders available,
that would reload the code into the DSP, once the PC
is rebooted in Linux.

 Firstly, is anyone aware of any  Linux based software
for code development on TI DSPs ?

If not, is the method I am using, the best thing to do
? Please cc the reply to my email address too, 'cos I
am not a member of this group.

Thanks in advance,
Dinesh


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
