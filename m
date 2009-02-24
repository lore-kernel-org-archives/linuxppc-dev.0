Return-Path: <wb1hbu@runbox.com>
Received: from aibo.runbox.com (aibo.runbox.com [87.238.52.70])
	by ozlabs.org (Postfix) with ESMTP id 36D99DDE2A
	for <linuxppc-dev@ozlabs.org>; Wed, 25 Feb 2009 03:57:07 +1100 (EST)
Content-Type: text/plain; charset="iso-8859-15"
MIME-Version: 1.0
From: "Eric Cottrell" <wb1hbu@runbox.com>
To: nvbolhuis@aimvalley.nl
Subject: Re: Can not get "new" MPC8313e-RDB to boot "as-shipped" flash image
Date: Tue, 24 Feb 2009 11:56:54 -0500 (EST)
References: <E1LbNft-0007z6-Pf@garm.runbox.com>
	<49A3EBFF.4030906@aimvalley.nl> <E1LbyOG-0000uL-Hf@garm.runbox.com>
	<49A4205B.30207@aimvalley.nl>
In-Reply-To: <49A4205B.30207@aimvalley.nl>
Message-Id: <E1Lc0aU-0000Hs-DJ@garm.runbox.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hello,

It never booted properly out of the box.

I raised the issue with the Distributor but have not heard back yet.

73 Eric

----- Start Original Message -----
Sent: Tue, 24 Feb 2009 17:29:15 +0100
From: Norbert van Bolhuis <nvbolhuis@aimvalley.nl>
To: Eric Cottrell <wb1hbu@runbox.com>
Subject: Re: Can not get "new" MPC8313e-RDB to boot "as-shipped" flash image

> Hi Eric,
>=20
> So it never ever booted properly ?
>=20
> Hmm, it certainly looks like your distributor (or whoever you got the MPC=
8313E-RDB
> from) lend it out and got a messed up board back. Or maybe they messed it=
 up
> themselfes.
>=20
> Go complain and send it back.
>=20
> indeed, rev 2.x is better (much less TSEC bugs).
>=20
> ---
> N. van Bolhuis.
>=20
>=20
>=20
> Eric Cottrell wrote:
> > Hello,
> >=20
> > Thanks for the help.  I will look into that.  It is confusing as the la=
test ltib appears not to have the aliases.  This is my first venture into E=
mbedded Linux as our existing PowerPC products use PSOS.  Most of my Linux =
experience is on the Intel PC platform.
> >=20
> > Yes, the 1.3.3 version was what was shipped with the board.  The rootfs=
 and kernel appear to be older.  So I suspect someone upgraded the uBoot an=
d ran into trouble.
> >=20
> > I am comparing this with the Rev B board we also got.  I hope to return=
 the Rev A4 and make the boards all Rev B because it has a later processor.=
  The Rev B boards have 1.3.0 so it should need the aliases as well.  Looki=
ng in the uBoot changelogs there are some nice additions and fixes for this=
 board so I will look to dig more into uBoot and upgrade it.  I hate to stu=
mble out of the box.
> >=20
> > 73 Eric
> >=20
>=20

----- End Original Message -----
