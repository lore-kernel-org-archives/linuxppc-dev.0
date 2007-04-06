Return-Path: <gschumac@brocade.com>
Received: from gate04out.mcdata.com (gate04out.mcdata.com [208.47.132.229])
	by ozlabs.org (Postfix) with ESMTP id AE718DDE3D
	for <linuxppc-embedded@ozlabs.org>;
	Fri,  6 Apr 2007 23:46:01 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset=us-ascii
Subject: Powerpc newbie help
Date: Fri, 6 Apr 2007 07:33:55 -0600
Message-ID: <E1FC5EDA57236147B397280C5E6C130032FDBA@MC4EXCH04.mcdata.com>
From: "Gary Schumacher" <gschumac@brocade.com>
To: <linuxppc-embedded@ozlabs.org>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

=20

I am in the process of upgrading a Linux kernel from 2.4,20 to 2.6.20 on
a proprietary board that uses the PPC 750Fx (without Open Firmware) and
am having the following problems:

=20
1.  Is there more information on Device Trees so I can construct one
myself?  I have been reading "Device trees everywhere" and
"booting-without-of".  Also, there are a number of *.dts files in
/arch/powerpc/boot/dts that I have been looking at but more
examples/HowTo information would be helpful.

2.  I have downloaded dtc-2006419.tar and was wondering if there is a
newer version or do I need patches for this and if so where would I
look?

3.  Where do I find glr_parser which is required to build dtc?

Thanks
=20
