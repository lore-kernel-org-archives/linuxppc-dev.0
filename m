Message-ID: <239A78AC110CD711A1A500D0B7828CD80C247B91@zhk08exm01.sps.mot.com>
From: Ho Jeffrey-r26191 <r26191@freescale.com>
To: linuxppc-embedded@lists.linuxppc.org
Subject: RE: UPM driver of MPC8260
Date: Wed, 30 Jun 2004 22:15:35 +0800
MIME-Version: 1.0
Content-Type: text/plain
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


I think that should be done in your bootcode.
If you are using u-boot, this should be part of your u-boot memory init which will init the upm, and memory map.

Not sure if PQ2 u-boot have upm, I think you can use the MPC8xx upm code as a starting point of your PQ2 upm init.

Regards,
Jeffrey Ho

-----Original Message-----
From: owner-linuxppc-embedded@lists.linuxppc.org [mailto:owner-linuxppc-embedded@lists.linuxppc.org]On Behalf Of Alireza Sadri
Sent: Wednesday, June 30, 2004 9:38 PM
To: linuxppc-embedded@lists.linuxppc.org
Subject: UPM driver of MPC8260



Hi all,

I am going to use UPM of my MPC8260; I need it for
handling a burstable SRAM.

I am using Wind River SBCPOWERQUICCII board. So I
think I need the configured UPM driver to be run on my
Linux.

Does ELDK have UPM initialization routines for my
purpose? Can I use this machine in a service then?

Can I have this driver for any other Linux, for
example VxWorks BSP? Can I configure my driver and use
it for SRAM?


Thanks a lot,
Regards.
A.R.Sadri Student of IUT.


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
