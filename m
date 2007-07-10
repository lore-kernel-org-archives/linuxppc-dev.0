Return-Path: <Antonio.DiBacco@technolabs.it>
Received: from smtp.technolabs.it (unknown [213.82.155.20])
	by ozlabs.org (Postfix) with ESMTP id D3EC7DDECB
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 11 Jul 2007 04:15:33 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: Talking to PHYs on MPC880
Date: Tue, 10 Jul 2007 20:15:29 +0200
Message-ID: <F1F6EC0C8B75034F9E3A79FC85122E8E977B81@aquib01a>
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

Hi,

I have an MPC880 with his FEC1 (eth0) connected via an MII-MII interface
to a switch.
The MPC880 controls (through its MDIO bus controller) the PHYs of the
switch. Each PHY has its own ethernet connector.

Because I don't want the FEC to bother about the status of the PHYs, I
chose to assign to the eth0 a "fixed@100:1" virtual PHY. Nevertheless, I
would like to read registers of the real PHYs but issueing the ioctl
SIOCGMIIREG  I actually access the (virtual) fixed PHY. How could I
handle this problem?
I can apply an ugly patch to fs_enet but I would like to receive and
advice to do a beautiful job.

Any help is appreciated.
