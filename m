Return-Path: <stephen.neuendorffer@xilinx.com>
Received: from outbound4-fra-R.bigfish.com (outbound-fra.frontbridge.com
	[62.209.45.174])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "*.bigfish.com", Issuer "*.bigfish.com" (not verified))
	by ozlabs.org (Postfix) with ESMTP id D41D0DDEBE
	for <linuxppc-embedded@ozlabs.org>;
	Tue,  7 Aug 2007 09:36:33 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Subject: RE: [PATCH] Consolidate XILINX_VIRTEX board support
Date: Mon, 6 Aug 2007 16:36:28 -0700
In-Reply-To: <200708070124.04748.arnd@arndb.de>
From: "Stephen Neuendorffer" <stephen.neuendorffer@xilinx.com>
To: "Arnd Bergmann" <arnd@arndb.de>,
	<linuxppc-embedded@ozlabs.org>
Message-Id: <20070806233630.95E233B0080@mail28-fra.bigfish.com>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


> On Tuesday 07 August 2007, Wolfgang Reissnegger wrote:
> >=20
> > Make support for Xilinx boards more generic, making it easier
> > to add new boards. =A0Add initial support for xupv2p and ml410 =
boards.
>=20
> I really think we shouldn't add stuff to arch/ppc at this point,
> it has been deprecated for over two years now.

This is a good point...  In fact the other patch (although tiny) is
more important, since it affects drivers, which should work in
arch/powerpc.  Thanks for the feedback anyway!

On this topic: has anyone tried using the recent Walnut patches for
arch/powerpc?   I briefly took a look at starting to port the Virtex
support to arch/powerpc but I'm a bit lost as to where to start... :)

Steve
