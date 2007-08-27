Return-Path: <daenzer@debian.org>
Received: from mail.gna.ch (darkcity.gna.ch [195.226.6.51])
	by ozlabs.org (Postfix) with ESMTP id 54A47DDF7F
	for <linuxppc-dev@ozlabs.org>; Mon, 27 Aug 2007 18:59:11 +1000 (EST)
Subject: Re: Sleep problems with kernels >= 2.6.21 on powerpc
From: Michel =?ISO-8859-1?Q?D=E4nzer?= <daenzer@debian.org>
To: =?ISO-8859-1?Q?Rog=E9rio?= Brito <rbrito@ime.usp.br>
In-Reply-To: <20070827065246.GA21220@ime.usp.br>
References: <6540c930708251937o2a9a23efv72a0f2b8947067bd@mail.gmail.com>
	<6bffcb0e0708261621q25316becqce7b3ae2176f45a8@mail.gmail.com>
	<20070827065246.GA21220@ime.usp.br>
Content-Type: text/plain; charset=UTF-8
Date: Mon, 27 Aug 2007 10:37:27 +0200
Message-Id: <1188203847.10738.357.camel@thor.sulgenrain.local>
Mime-Version: 1.0
Cc: Michal Piotrowski <michal.k.k.piotrowski@gmail.com>,
	=?ISO-8859-1?Q?Rog=E9rio?= Brito <rbrito@gmail.com>,
	linux-kernel@vger.kernel.org, "Rafael J. Wysocki" <rjw@sisk.pl>,
	linuxppc-dev@ozlabs.org, debian-powerpc@lists.debian.org,
	Linux-pm mailing list <linux-pm@lists.linux-foundation.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, 2007-08-27 at 03:52 -0300, Rog=C3=A9rio Brito wrote:
>=20
> I did 13 compiles with git bisect and some of them were unsucessfuly
> compiled, which I am afraid that may miss the real cause if I tag them as
> being "bad" (which I did).

Yes, don't mark such cases as bad or good but look for a nearby commit
that compiles.


--=20
Earthling Michel D=C3=A4nzer           |          http://tungstengraphics.c=
om
Libre software enthusiast         |          Debian, X and DRI developer
