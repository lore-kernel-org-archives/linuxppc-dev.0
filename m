Return-Path: <Antonio.DiBacco@technolabs.it>
Received: from smtp.technolabs.it (unknown [213.82.155.20])
	by ozlabs.org (Postfix) with ESMTP id D98F7DDE48
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 22 Aug 2007 19:08:54 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: Only one phy can be accessed through ioctls to a socket (patch
	available)
Date: Wed, 22 Aug 2007 10:56:39 +0200
Message-ID: <F1F6EC0C8B75034F9E3A79FC85122E8EA1809A@aquib01a>
From: "DI BACCO ANTONIO - technolabs" <Antonio.DiBacco@technolabs.it>
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

In file fs_enet-main.c in function fs_ioctl the phy_mii_ioctl can be
issued only to the phydev associated with the FEC. If I have several
PHYs and only one associated to the FEC I cannot access all the  PHYs. I
have a patch to overcome this limitation, is it interesting or not
useful?
=20
I need this patch because I have instantiated a virtual "Fixed PHY" and
I have associated it to my FEC,  anyway I would like to access registers
of my physical PHY.
=20
Bye.
