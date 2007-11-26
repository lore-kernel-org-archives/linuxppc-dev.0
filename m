Return-Path: <SRS0=j6VG=QT=denx.de=sr@srs.kundenserver.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.174]) by ozlabs.org (Postfix) with ESMTP id A5C00DDF39
	for <linuxppc-dev@ozlabs.org>; Tue, 27 Nov 2007 03:24:42 +1100 (EST)
From: Stefan Roese <sr@denx.de>
To: linuxppc-dev@ozlabs.org
Subject: Re: Sequoia EMAC only works if u-boot initializes it?
Date: Mon, 26 Nov 2007 17:20:26 +0100
References: <474AED67.4020006@harris.com>
In-Reply-To: <474AED67.4020006@harris.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200711261720.26629.sr@denx.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Monday 26 November 2007, Steven A. Falco wrote:
> I have noticed odd behavior on a Sequoia board.  Kernel is built from
> DENX git, ARCH=powerpc, 2.6.23.1.
>
> Sequence that works:
> 1) In u-boot, do "dhcp" (this initializes the PHY)
> 2) Boot linux from flash
> 3) ifconfig eth0 192.168.0.101 netmask 255.255.255.0 up
> Ethernet is now functional, and I can ping the Sequoia (and it can ping
> my host)
>
> Sequence that does not work:
> 1) Boot linux from flash without letting u-boot touch eth0
> 2) ifconfig eth0 192.168.0.101 netmask 255.255.255.0 up
> Ethernet appears to come up, but it is not functional.  I.e. I get
> "eth0: link is up, 100 FDX, pause enabled" but I cannot ping the board,
> and the board cannot ping my host.

Do you have a 100MBit connection? Or Gbit? Could you please send the complete 
bootlog.

> So, the kernel appears to be missing some initialization that u-boot
> provides.
>
> However, eth1 is more strange.  U-boot can use it (via "setenv ethact
> ppc_4xx_eth1;dhcp"), however, the kernel cannot use it, whether or not
> u-boot first initializes it.
>
> If anyone has suggestions on where to look, I'd appreciate it.  I'm
> going to look at the PHY register settings and see if there are any
> clues there...

Again it would be interesting to see the bootlog here.

Best regards,
Stefan

=====================================================================
DENX Software Engineering GmbH,     MD: Wolfgang Denk & Detlev Zundel
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: +49-8142-66989-0 Fax: +49-8142-66989-80  Email: office@denx.de
=====================================================================
