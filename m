Return-Path: <B32579@freescale.com>
Received: from TX2EHSOBE007.bigfish.com (tx2ehsobe004.messaging.microsoft.com
	[65.55.88.14]) (using TLSv1 with cipher AES128-SHA (128/128 bits))
	(Client CN "mail.global.frontbridge.com",
	Issuer "Cybertrust SureServer Standard Validation CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 80846B6FBD
	for <linuxppc-dev@ozlabs.org>; Fri, 15 Apr 2011 16:27:46 +1000 (EST)
From: Kushwaha Prabhakar-B32579 <B32579@freescale.com>
To: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>
Subject: RE: Problem with mini-PCI-E slot on P2020RDB
Date: Fri, 15 Apr 2011 06:27:42 +0000
Message-ID: <071A08F2C6A57E4E94D980ECA553F87417BAF7@039-SN1MPN1-004.039d.mgd.msft.net>
References: <45903308677306428B6EE7E6FF5A520410D3E6@039-SN1MPN1-004.039d.mgd.msft.net>
In-Reply-To: <45903308677306428B6EE7E6FF5A520410D3E6@039-SN1MPN1-004.039d.mgd.msft.net>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Cc: "leon.woestenberg@gmail.com" <leon.woestenberg@gmail.com>,
	Felix Radensky <felix@embedded-sol.com>,
	Aggrwal Poonam-B10812 <B10812@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Added Linxppc-dev

> -----Original Message-----
> From: Aggrwal Poonam-B10812
> Sent: Friday, April 15, 2011 11:47 AM
> To: Felix Radensky
> Cc: Kushwaha Prabhakar-B32579; leon.woestenberg@gmail.com
> Subject: FW: Problem with mini-PCI-E slot on P2020RDB
>=20
> Hello Felix
>=20
> We checked with the Board designer, we need the board fixes "mentioned in
> Board errata doc" on the board for this issue. Sorry for the confusion.
>=20
> The fixes are not present on RevC, also on some RevDs this fix also may
> be absent.
>=20
>=20
> Please let us know in case of any issues.
>=20
> Regards
> Poonam
>=20
> > -----Original Message-----
> > From: Leon Woestenberg [mailto:leon.woestenberg@gmail.com]
> > Sent: Wednesday, April 13, 2011 2:52 PM
> > To: Felix Radensky
> > Cc: Aggrwal Poonam-B10812; linuxppc-dev@ozlabs.org; Gupta
> > Maneesh-B18878; Kushwaha Prabhakar-B32579
> > Subject: Re: Problem with mini-PCI-E slot on P2020RDB
> >
> > Felix,
> >
> > On Tue, Apr 12, 2011 at 6:54 AM, Felix Radensky
> > <felix@embedded-sol.com>
> > wrote:
> > > On 04/12/2011 07:05 AM, Aggrwal Poonam-B10812 wrote:
> > >> As such there is no hardware fix related to this issue between RevC
> > >> to RevD. The solution was a software patch to resolve the issue
> > >> related to IRQ0.
> > >
> > > Are you sure ? Please take a look at Freescale document titled
> > > "P1020E/P2020E RDB System Errata".
> > > There's errata CE10, IRQ0 held low. It is fixed in Rev D. Vivek
> > > Mahajan, who looked at the issue back in 2009, estimated that
> > > problem can be related to missing pull-up on IRQ0.
> > > This is exactly what is
> > > fixed in Rev D.
> > >
> >
> > That's my understanding as well.
> >
> > Check if R420 and R423 are populated. These are the required pull-ups.
> > On Rev D they are populated. You might be able to add them yourself.
> >
> > Even if you have an Rev A-C PCB, this fix can already be applied; it
> > was on my board! (the bottom of the board mentions the schematic
> > revision)
> >
> > The resistors have a silkscreen designator block called X, the
> > resistors are situated to the left and bottom of the silkscreen X.
> > IIRC, between the flash and Px020 part.
> >
> > On the left side of R420 (or R423) I measured the block wave from the
> > RTC, which fires the 32kHz interrupt rate on IRQ0. This fixed by the
> > u- boot patch.
> >
> > Regards,
> >
> > Leon.
