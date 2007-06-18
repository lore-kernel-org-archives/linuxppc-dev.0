Return-Path: <joakim.tjernlund@transmode.se>
Received: from tmnt04.transmode.se (mail.transmode.se [83.241.175.147])
	by ozlabs.org (Postfix) with ESMTP id 26420DDEEC
	for <linuxppc-dev@ozlabs.org>; Mon, 18 Jun 2007 23:24:44 +1000 (EST)
Subject: Re: [PATCH] rheap: eliminates internal fragments caused by alignment
From: Joakim Tjernlund <joakim.tjernlund@transmode.se>
To: Pantelis Antoniou <pantelis.antoniou@gmail.com>
In-Reply-To: <DA299F48-E5A6-495C-8169-A211D4C83864@gmail.com>
References: <46766C91.6090903@freescale.com>
	<03F6FDB0-3D7B-4272-AC1C-8E06F82DD815@gmail.com>
	<1182169549.2969.20.camel@gentoo-jocke.transmode.se>
	<DA299F48-E5A6-495C-8169-A211D4C83864@gmail.com>
Content-Type: text/plain; charset=UTF-8
Date: Mon, 18 Jun 2007 15:24:42 +0200
Message-Id: <1182173082.2969.28.camel@gentoo-jocke.transmode.se>
Mime-Version: 1.0
Cc: linuxppc-dev Development <linuxppc-dev@ozlabs.org>,
	Li Yang <leoli@freescale.com>, Paul <paulus@samba.org>,
	Vitaly Bordug <vbordug@ru.mvista.com>
Reply-To: joakim.tjernlund@transmode.se
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, 2007-06-18 at 15:31 +0300, Pantelis Antoniou wrote:
> On 18 =CE=99=CE=BF=CF=85=CE=BD 2007, at 3:25 =CE=9C=CE=9C, Joakim Tjernlu=
nd wrote:
>=20
> > On Mon, 2007-06-18 at 15:14 +0300, Pantelis Antoniou wrote:
> >> Hi Li,
> >>
> >> The patch appears fine at first glance.
> >>
> >> I'm really curious what kind of alignment do you use in order to =20
> >> have so
> >> much wasted space that re-inserting the leftovers makes so much of a
> >> difference.
>=20
> Jocke,
>=20
> Ugh, 256?

Yes, the ucc_geth needs lots of alignment. Leo can tell you more :)

>=20
> That's not nice at all.
> I'm not sure that even then you're going to have any guarantees that
> the allocations will be successful.
>=20
> I'm afraid that in those case it would be better for the board
> platform setup to have the space preallocated according to the BSP
> requirements.

Maybe, but without the PATCH you will run out of space very quickly
and you cannot bring up 3 ethernet interfaces. Rheap is plain wrong
as is today and needs this patch.

 Jocke

>=20
> Just my $0.02.
>=20
> -- Pantelis
