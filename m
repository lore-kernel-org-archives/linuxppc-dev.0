Return-Path: <Horst.KRONSTORFER@frequentis.com>
Received: from webmail.frequentis.com (webmail.frequentis.com [213.47.210.151])
	by ozlabs.org (Postfix) with ESMTP id 849F9679FD
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 24 Oct 2006 19:28:38 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: MPC834x TSECs/Gianfar w/o MDIO accessible PHYs
Date: Tue, 24 Oct 2006 11:16:28 +0200
Message-ID: <CAB1644F1C94A24BAC68B05D0F9774635CC446@VIECLEX01.frequentis.frq>
From: "KRONSTORFER Horst" <Horst.KRONSTORFER@frequentis.com>
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

hi!

in our design we use an mpc8343 with the 2 tsecs connected to a
zarlink zl50411 eth switch in mii mode. the 2 ports of the switch
are running in phy mode (reverse mii) w/o mdio. we're currently
running kernel 2.6.17.13.

i therefore 'simply' removed the mdio bus and phy support and tested
with ping over tsec0. result: i can see arp requests which are some-
what malformed (dest mac addr is not bcast, source ip addr is incorrect,
etc ...) btw: i used the same approach in u-boot and it works fine.

i then checked the content of the sk_buff handed over to gfar_start_xmit
which is correct (mac addrs, ip addrs, ...)

i'm currently out of ideas, any kind of help is appreciated!

thanks
-h
