Message-ID: <20031024171504.23157.qmail@web40805.mail.yahoo.com>
Date: Fri, 24 Oct 2003 10:15:04 -0700 (PDT)
From: sakthivel kariappan <sakvel_k@yahoo.com>
Subject: Porting VxWorks to Apple Mac PowerPC G4
To: linuxppc-dev@lists.linuxppc.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


 Hi All,
 I'm trying to understand the complexities involved
 in porting vxworks to PowerPc G4. I already have the
 port for MPC740 based board. I'm sure some of you
 might have done the linux porting. That's why posting
 to this mail-group.

 The question is related to open firmware, CHRP and
 run time drivers. As per my understanding, it
requires
 understanding the device tree to obtain CPU, PCI  bus
 and peripherals and how it is connected. As a side
 note, PowerPC G4 Xserve cluster node uses two custom
 made ICs (U2-bridge and memory controller and
KeyLargo
 IO controller and disk)

 Now, how do I know about clock (and timers),
interrupt
 structure and registers etc to configure the
 devices.  Also, OF says, it should provide basic run
 time drivers. Now, How do I invoke the drivers that
 comes with boot ROM? and performing VxWorks
 intialization. Or should I have to write drivers?

 I don't see any documentation at apple developers
site
 and in the internet that helps much.

 Any documentation available will be helpful (I read
 through apple  technocal notes 1167, 2000, 1061,
 1062,  2001, 2004, 2023 and 1167).
 But, I don't seem to find enough information.

 Appreciate any information.

 Thanks,
 Sak


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
