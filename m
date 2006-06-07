Return-Path: <hlrprasad@tataelxsi.co.in>
Received: from mail.tataelxsi.co.in (mail.tataelxsi.co.in [203.200.1.48])
	(using TLSv1 with cipher DES-CBC3-SHA (168/168 bits))
	(Client CN "myname.my.domain",
	Issuer "www.mirapoint.com" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 878B367B37
	for <linuxppc-embedded@ozlabs.org>;
	Wed,  7 Jun 2006 15:42:14 +1000 (EST)
From: Ram Prasad H L <hlrprasad@tataelxsi.co.in>
To: <linuxppc-embedded@ozlabs.org>
Subject: Problem in PCI with MPC5200B
Date: Wed, 7 Jun 2006 11:05:16 +0530
Message-ID: <000d01c689f4$281750c0$4129320a@telxsi.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Reply-To: Ram Prasad H L <hlrprasad@tataelxsi.co.in>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

hi all,
	We are using a customised board which is based on
	the reference design of lite5200B. But our board is customised by adding
	a PCI-PCI Bridge on the primary bus. On the secondary bus we have added
	a DSP(DM642) along with 2 PCI slots, which are routed through
	bridge (PCI2250) to MPC5200B.

	As far as software is concerned we are using "mpc5200_lite_K26-BSP-b30"
	BSP downloaded from freescale's website for lite5200B. This BSP has a
	u-boot-1.1.3 and linux kernel-2.6.11.7. As far as u-boot is concerned
	the PCI devices are allocated and assigned with proper resources (BAR's)
	which come under the range for Mem region(40000000 - 4fffffff) and I/O
	region (50000000 - 50ffffff). But during the boot process of linux we
	are getting the following errors:


****************************************************************************
***
	PCI: Probing PCI hardware
	PCI: Cannot allocate resource region 1 of PCI bridge 1
	PCI: bridge 1 resource 1 moved to 4ff00000..4fffffff
	PCI: Cannot allocate resource region 2 of PCI bridge 1
	PCI: bridge 1 resource 2 moved to 4fe00000..4fefffff
	PCI: Failed to allocate mem resource #0: 400000 @ 50000000 for 0000:01:08.0
	PCI: Failed to allocate mem resource #1: 800000 @ 50000000 for 0000:01:08.0
	PCI: Failed to allocate I/O resource #2: 10 @ 1000 for 0000:01:08.0

****************************************************************************
****

	where 0000:01:08.0 is the dev function address for DM642(DSP).

	I'm stuck up with this problem since long time. Plz help me in giving some
pointers
	for overcoming this problem as i'm a newbie to linux-pci. Any patches for
the kernel
	2.6.11.7 which can resolve the above problem would be of great help.


Thanks and regards,
Ramprasad



The information contained in this electronic message and any attachments to this message are intended for the exclusive use of the addressee(s)and may contain confidential or privileged information. If you are not the intended recipient, please notify the sender or administrator@tataelxsi.co.in
