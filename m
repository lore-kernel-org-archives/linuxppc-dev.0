Return-Path: <LeoLi@freescale.com>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 5469FB7BFC
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 13 Aug 2009 19:00:22 +1000 (EST)
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id D5B78DDDA0
	for <linuxppc-dev@ozlabs.org>; Thu, 13 Aug 2009 19:00:20 +1000 (EST)
Received: from de01smr02.am.mot.com (de01smr02.freescale.net [10.208.0.151])
	by az33egw02.freescale.net (8.14.3/az33egw02) with ESMTP id
	n7D8xwAN024244
	for <linuxppc-dev@ozlabs.org>; Thu, 13 Aug 2009 02:00:09 -0700 (MST)
Received: from zch01exm26.fsl.freescale.net (zch01exm26.ap.freescale.net
	[10.192.129.221])
	by de01smr02.am.mot.com (8.13.1/8.13.0) with ESMTP id n7D90gJs022390
	for <linuxppc-dev@ozlabs.org>; Thu, 13 Aug 2009 04:00:43 -0500 (CDT)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: ARM clock API to PowerPC
Date: Thu, 13 Aug 2009 16:59:54 +0800
Message-ID: <3A45394FD742FA419B760BB8D398F9ED59DE33@zch01exm26.fsl.freescale.net>
In-Reply-To: <1250112599.3587.21.camel@pasglop>
References: <1250063825.15143.43.camel@pasglop><20090812111954.GB31596@zod.rchland.ibm.com><4A90486C-8BF5-428C-9FD8-830D822C0D40@kernel.crashing.org>
	<1250112599.3587.21.camel@pasglop>
From: "Li Yang-R58472" <LeoLi@freescale.com>
To: "Benjamin Herrenschmidt" <benh@kernel.crashing.org>,
	"Kumar Gala" <galak@kernel.crashing.org>
Cc: John Jacques <john.jacques@lsi.com>,
	linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	devicetree-discuss@lists.ozlabs.org, Torez Smith <torez@us.ibm.com>,
	Russell King <rmk@arm.linux.org.uk>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


>Now, I know there is at least one person on earth=20
>contemplating sharing some drivers between PPC and ARM. I=20
>won't tell much more at this stage, but it makes sense in the=20
>grand scheme of things to see SoC vendors put similar IO cores=20
>into either PPC or ARM and providing that clock API is a good=20
>way to also allow these drivers to work since the drivers in=20
>questions make use of it.

Freescale USB UDC driver is another example that shared between PowerPC
and ARM(i.mx).  Currently, the imx part of the driver uses clk API, but
PowerPC part uses static initialization.  It will be better if we can
unify the clk setting part of the driver.

- Leo
