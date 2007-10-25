Return-Path: <scottwood@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 49283DDE35
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 26 Oct 2007 08:08:15 +1000 (EST)
Message-ID: <472113CC.5020409@freescale.com>
Date: Thu, 25 Oct 2007 17:08:12 -0500
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: Rune Torgersen <runet@innovsys.com>
Subject: Re: Porting to /arch/powerpc
References: <DCEAAC0833DD314AB0B58112AD99B93B038A279C@ismail.innsys.innovsys.com>
In-Reply-To: <DCEAAC0833DD314AB0B58112AD99B93B038A279C@ismail.innsys.innovsys.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Rune Torgersen wrote:
> Is there a good platform/documents to look at for doing a board port
> from arch/ppc to arch/powerpc?
> I'm porting a 8266/8280 based board with PCI and 2 FCC ethernets
> connected phy-less to a switch.

Look at head-of-tree for 82xx stuff (lots of changes since 2.6.23)... 
any of the 82xx boards in arch/powerpc should be good to look at.

The fs_enet driver doesn't currently support phy-less directly, but you 
may be able to do something with the fixed phy driver.

-Scott
