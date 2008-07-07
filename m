Return-Path: <arnd@arndb.de>
From: Arnd Bergmann <arnd@arndb.de>
To: cbe-oss-dev@ozlabs.org
Subject: Re: [Cbe-oss-dev] [patch 05/11] powerpc/cell: add spu
	=?utf-8?q?aware=09cpufreq?= governor
Date: Mon, 7 Jul 2008 23:15:13 +0200
References: <20080704190535.316377278@arndb.de>
	<200807071659.23476.arnd@arndb.de>
	<1215444942.20774.50.camel@weaponx>
In-Reply-To: <1215444942.20774.50.camel@weaponx>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Message-Id: <200807072315.13666.arnd@arndb.de>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Monday 07 July 2008, Josh Boyer wrote:
> 0% probability of being spam.
>=20
> Full report:
> No, score=3D-2.6 required=3D5.0 tests=3DAWL,BAYES_00 autolearn=3Dham vers=
ion=3D3.2.4 =C2=A0
> On Mon, 2008-07-07 at 16:59 +0200, Arnd Bergmann wrote:
> > On Monday 07 July 2008, Stephen Rothwell wrote:
> > > > +#define POLL_TIME =C2=A0 =C2=A0100000 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0/* in us */
> > > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 ^
> > > How about =CE=BC ?
> >=20
> > Not sure, how about =C2=B5 instead? ;-)
>=20
> Erm... don't get it. =C2=A0You have identical characters here.

That depends on the tool you use to look at it.

Stephen wrote a Unicode character U+03BC from the Greek alphabet part of
unicode, I wrote unicode character U+00B5 from the Latin-1 code page.
In my mail client, latin-1 characters get rendered in the default font,
but it has to change the font for less common scripts.

	Arnd <><
