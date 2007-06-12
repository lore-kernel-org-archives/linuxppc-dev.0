Return-Path: <arnd@arndb.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.187]) by ozlabs.org (Postfix) with ESMTP id DDCB9DE01E
	for <linuxppc-dev@ozlabs.org>; Wed, 13 Jun 2007 05:25:29 +1000 (EST)
From: Arnd Bergmann <arnd@arndb.de>
To: linuxppc-dev@ozlabs.org
Subject: Re: [patch 00/18] PS3 patches for 2.6.23
Date: Tue, 12 Jun 2007 21:25:19 +0200
References: <71e5ae7f85657e4ab5bfbc809cab9c60@bga.com>
	<466EE45A.4050104@am.sony.com>
In-Reply-To: <466EE45A.4050104@am.sony.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200706122125.19398.arnd@arndb.de>
Cc: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>,
	Milton Miller <miltonm@bga.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tuesday 12 June 2007, Geoff Levand wrote:
>=20
> > The dependent series is currently split per file. =A0 While this makes =
it=20
> > easier to see what a given area looks like after all the patches, it=20
> > means that the kernel compile will break during the series. =A0Breaking=
=20
> > git bisect is frowned upon, so it will need to be re-split for merge. =
=A0
> > (Or disable the ps3 system bus during the merge of the series).
>=20
>=20
> Yes, I realize the state of the patches. =A0I will try to rework them for
> the next round. =A0As the existing PS3 support is incomplete, I don't
> think there will be many doing a git-bisect with PS3 support enabled.

I think it's ok to split the patches like this for review purposes.

=46or the upstream merge, it's probably best if Geoff commits all
patches with cross-dependencies as a single git checkin, and asks
Paul (or me) to pull from there. That will take care of the git-bisect
problem, and give a nicer changelog at the same time.

Of course, patches that only have directed dependencies should go
in as separate changesets whereever that makes sense.

	Arnd <><
