Return-Path: <ALEBAS@televes.com>
Received: from televes.com (unknown [212.163.42.137])
	by ozlabs.org (Postfix) with SMTP id 4F7F92BDB8
	for <linuxppc-embedded@ozlabs.org>;
	Tue,  5 Oct 2004 16:43:51 +1000 (EST)
Message-ID: <51DB8827D393D411BB69003048003F46FDCF23@tvesntr.televes.com>
From: Bastos Fernandez Alexandre <ALEBAS@televes.com>
To: "'linuxppc-embedded@ozlabs.org'" <linuxppc-embedded@ozlabs.org>
Date: Tue, 5 Oct 2004 08:41:27 +0200 
MIME-Version: 1.0
Content-Type: text/plain
Cc: 
Subject: full duplex, mdio and both ethernet in mpc8272ads
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

>I use the fcc enet driver and a dual port phy using the fcc driver's mii
>implementation on a 8270, but on a propietary board design.

After your reply I checked my work. I upgraded into the last version of
linuxppc-2.4 from ppc.bkbits.net, which is version 2.4.27 of the kernel and
1.22 of the fcc_enet driver, and then MII management and Full-duplex seemed
to work.

However, the second interface were still not working. I have seen that one
reason could be the second PHY not being enabled during device init
(BCSR3_FETHIEN2), while the first PHY were. I changed it and now, i think it
works. At least, it answer and sends echoes.

Thanks

Alex Bastos

>Jaap-Jan
