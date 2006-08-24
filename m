Return-Path: <tie-fei.zang@freescale.com>
Received: from de01egw02.freescale.net (de01egw02.freescale.net
	[192.88.165.103]) by ozlabs.org (Postfix) with ESMTP id 89FA067CE1
	for <linuxppc-dev@ozlabs.org>; Thu, 24 Aug 2006 15:54:47 +1000 (EST)
Received: from de01smr01.freescale.net (de01smr01.freescale.net [10.208.0.31])
	by de01egw02.freescale.net (8.12.11/de01egw02) with ESMTP id
	k7O66vO8014456
	for <linuxppc-dev@ozlabs.org>; Wed, 23 Aug 2006 23:06:57 -0700 (MST)
Received: from zch01exm23.fsl.freescale.net (zch01exm23.ap.freescale.net
	[10.192.129.207])
	by de01smr01.freescale.net (8.13.1/8.13.0) with ESMTP id k7O5sh1X003002
	for <linuxppc-dev@ozlabs.org>; Thu, 24 Aug 2006 00:54:45 -0500 (CDT)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: [PATCH ] powerpc:  pass UPIO_TSI flag to 8259 serial driver
Date: Thu, 24 Aug 2006 13:54:42 +0800
Message-ID: <7EA18FDD2DC2154AA3BD6D2F22A62A0E26E738@zch01exm23.fsl.freescale.net>
In-Reply-To: <4879B0C6C249214CBE7AB04453F84E4D0FC2F6@zch01exm20.fsl.freescale.net>
From: "Zang Roy-r61911" <tie-fei.zang@freescale.com>
To: "Li Yang-r58472" <LeoLi@freescale.com>,
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

> > On Thu, 2006-08-24 at 13:17, Benjamin Herrenschmidt wrote:
> > > > Evolution 1.2.2. I had found the reason and tested on my side.
> > > > Paul, if you do not modify it by hand, please select=20
> the following
> > > :-).
> > > > I will repost the mpic and mpc7448hph2 irq update=20
> patch.Very sorry
> > > for that.
> > >
> > > Ok, the trick with evolution is to use the "preformat" style.
> > >
> > > Typically, when posting a patch, I write my description, put the=20
> > > caret where I want to insert the patch itself, set the style to=20
> > > "Preformat" (from the pop-up menu just above the text=20
> editing zone),=20
> > > and do Insert->Text File from the menu.
> > >
> > > You can also select a bit of text/patch and change the style to=20
> > > "Preformat" afterward if you missed it before doing the import.
> > >
> > You words are  principle to post patch with evolution :-).
>=20
> Why did no one ever add a mail client guide to the kernel=20
> documentation?  It seems such problem happens a lot.
>=20

I think there should be one in other place. But we do not know where it
is.
I have tried Thunderbird, but failed.

Roy
