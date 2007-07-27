Return-Path: <Wei.Zhang@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id CC4D2DDE1C
	for <linuxppc-dev@ozlabs.org>; Fri, 27 Jul 2007 19:12:37 +1000 (EST)
Received: from az33smr01.freescale.net (az33smr01.freescale.net [10.64.34.199])
	by az33egw01.freescale.net (8.12.11/az33egw01) with ESMTP id
	l6R9CW1P027065
	for <linuxppc-dev@ozlabs.org>; Fri, 27 Jul 2007 02:12:33 -0700 (MST)
Received: from zch01exm26.fsl.freescale.net (zch01exm26.ap.freescale.net
	[10.192.129.221])
	by az33smr01.freescale.net (8.13.1/8.13.0) with ESMTP id l6R9CVg1000855
	for <linuxppc-dev@ozlabs.org>; Fri, 27 Jul 2007 04:12:32 -0500 (CDT)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Subject: RE: [PATCH 1/5 v3] Add the explanation and a sample of RapidIO OF
	node to the document of booting-without-of.txt file.
Date: Fri, 27 Jul 2007 17:12:31 +0800
Message-ID: <46B96294322F7D458F9648B60E15112C74D158@zch01exm26.fsl.freescale.net>
In-Reply-To: <98CA70A1-9888-4508-A0E9-0EB28C14945F@kernel.crashing.org>
References: <11854393721520-git-send-email-wei.zhang@freescale.com>
	<11854393733580-git-send-email-wei.zhang@freescale.com>
	<98CA70A1-9888-4508-A0E9-0EB28C14945F@kernel.crashing.org>
From: "Zhang Wei-r63237" <Wei.Zhang@freescale.com>
To: "Kumar Gala" <galak@kernel.crashing.org>
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi, Kumar,=20
> +   RapidIO is a definition of a system interconnect. This node add
> > +   the support for RapidIO processor in kernel. The node name is
> > +   suggested to be 'rapidio'.
> > +
> > +   Required properties:
> > +
> > +    - compatible : Using "fsl,rapidio-delta" for Freescale PowerPC
> > +      RapidIO controller.
> > +    - #address-cells : Address representation for=20
> "rapidio" devices.
> > +      This field represents the number of cells needed to represent
> > +      the RapidIO address of the registers.
>=20
> Can you explain this a little further.  I'm a bit confused by =20
> 'RapidIO address of the registers'.
>=20
I want to present "This field represents the number of cells [needed to
represent the RapidIO address] of the registers."
Maybe I should remove 'of the registers' to be more clear.

Thanks!
-zw
