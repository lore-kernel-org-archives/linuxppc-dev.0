Return-Path: <arnd@arndb.de>
From: Arnd Bergmann <arnd@arndb.de>
To: linuxppc-embedded@ozlabs.org
Subject: Re: [PATCH] Add AMCC Arches 460GT eval board support to platforms/44x
Date: Wed, 16 Jul 2008 16:46:01 +0200
References: <1216186406-27993-1-git-send-email-fkan@amcc.com>
	<20080716075025.0bca152c@zod.rchland.ibm.com>
	<20080716141539.GC24045@secretlab.ca>
In-Reply-To: <20080716141539.GC24045@secretlab.ca>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200807161646.02306.arnd@arndb.de>
Cc: linuxppc-dev@ozlabs.org, Victor Gallardo <vgallard@amcc.com>, fkan@amcc.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wednesday 16 July 2008, Grant Likely wrote:
>=20
> >=20
> > And then you don't need this file at all. =A0Just add a
> > "amcc,canyonlands" string to your root node compatible property.
>=20
> No! =A0Don't do this because it is not true!
>=20
> Instead, add your board name to canyonlands.c in canyonlands_probe().
> It's not the most scalable solution, but it keeps you from lying about
> your hardware in the .dts file.
>=20
> I'm working on a more scalable solution for this, but for now just add
> your specific board to canyonlands_probe().

Shouldn't it be enough to have a common compatible value in each
of these boards, e.g. "amcc,generic-ppc44x" and then just ignore the
specific type unless you need to do something special?

=46or all I can tell, bamboo, canyonlands, katmai, rainier, sequoia
and taishan setup is already identical except for their names, while
ebony and Sam440ep are almost the same, except for their RTC device
probing (which should be done in a generic way as well ;-)).

	Arnd <><
