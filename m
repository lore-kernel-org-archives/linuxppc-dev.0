Return-Path: <LeoLi@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103]) by ozlabs.org (Postfix) with ESMTP id 7E64767C1A
	for <linuxppc-dev@ozlabs.org>; Thu, 24 Aug 2006 15:49:01 +1000 (EST)
Received: from az33smr02.freescale.net (az33smr02.freescale.net [10.64.34.200])
	by az33egw02.freescale.net (8.12.11/az33egw02) with ESMTP id
	k7O5mxaf003192
	for <linuxppc-dev@ozlabs.org>; Wed, 23 Aug 2006 22:48:59 -0700 (MST)
Received: from zch01exm20.fsl.freescale.net (zch01exm20.ap.freescale.net
	[10.192.129.204])
	by az33smr02.freescale.net (8.13.1/8.13.0) with ESMTP id k7O5mv4M028225
	for <linuxppc-dev@ozlabs.org>; Thu, 24 Aug 2006 00:48:58 -0500 (CDT)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Subject: RE: [PATCH ] powerpc:  pass UPIO_TSI flag to 8259 serial driver
Date: Thu, 24 Aug 2006 13:49:27 +0800
Message-ID: <4879B0C6C249214CBE7AB04453F84E4D0FC2F6@zch01exm20.fsl.freescale.net>
In-Reply-To: <1156397928.5913.38.camel@localhost.localdomain>
From: "Li Yang-r58472" <LeoLi@freescale.com>
To: "Zang Roy-r61911" <tie-fei.zang@freescale.com>,
	"Benjamin Herrenschmidt" <benh@kernel.crashing.org>
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	Paul Mackerras <paulus@samba.org>,
	Yang Xin-Xin-r48390 <Xin-Xin.Yang@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> -----Original Message-----
> From: linuxppc-dev-bounces+leoli=3Dfreescale.com@ozlabs.org
> [mailto:linuxppc-dev-bounces+leoli=3Dfreescale.com@ozlabs.org] On =
Behalf
Of Zang
> Roy-r61911
> Sent: Thursday, August 24, 2006 1:39 PM
> To: Benjamin Herrenschmidt
> Cc: linuxppc-dev list; Paul Mackerras; Yang Xin-Xin-r48390
> Subject: Re: [PATCH ] powerpc: pass UPIO_TSI flag to 8259 serial
driver
>=20
> On Thu, 2006-08-24 at 13:17, Benjamin Herrenschmidt wrote:
> > > Evolution 1.2.2. I had found the reason and tested on my side.
> > > Paul, if you do not modify it by hand, please select the following
> > :-).
> > > I will repost the mpic and mpc7448hph2 irq update patch.Very sorry
> > for that.
> >
> > Ok, the trick with evolution is to use the "preformat" style.
> >
> > Typically, when posting a patch, I write my description, put the
caret
> > where I want to insert the patch itself, set the style to
> > "Preformat" (from the pop-up menu just above the text editing zone),
> > and
> > do Insert->Text File from the menu.
> >
> > You can also select a bit of text/patch and change the style to
> > "Preformat" afterward if you missed it before doing the import.
> >
> You words are  principle to post patch with evolution :-).

Why did no one ever add a mail client guide to the kernel documentation?
It seems such problem happens a lot.
