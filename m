Return-Path: <Antonio.DiBacco@technolabs.it>
Received: from smtp.technolabs.it (unknown [213.82.155.20])
	by ozlabs.org (Postfix) with ESMTP id 58868DDE08
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 30 Aug 2007 04:38:24 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: Register MII_SPEED periodically set to 0 (who is it?)
Date: Wed, 29 Aug 2007 20:38:23 +0200
Message-ID: <F1F6EC0C8B75034F9E3A79FC85122E8EA18699@aquib01a>
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

I had to add a setting of mii_speed register of MPC880  in mdio_read and
mdio_write of mii-fec.c because it was periodically set to 0.
My fs_enet is bind to a Virtual PHY and I don't understand who touches
this register.
=20
Bye,
Antonio.
