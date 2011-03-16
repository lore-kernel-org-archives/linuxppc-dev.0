Return-Path: <acrux_it@libero.it>
Received: from cp-out12.libero.it (cp-out12.libero.it [212.52.84.112])
	by ozlabs.org (Postfix) with ESMTP id B9163B6FFE
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 16 Mar 2011 11:23:29 +1100 (EST)
Date: Wed, 16 Mar 2011 01:23:19 +0100
From: acrux <acrux_it@libero.it>
To: Sven Luther <sven.luther@z-innov.com>
Subject: Re: any chance to use a modern linux kernel on Pegasos1 G3 ?
Message-Id: <20110316012319.b436ee11.acrux_it@libero.it>
In-Reply-To: <20110315214149.GA26249@z-innov.com>
References: <AANLkTimJwBfz=RksRtuj3M2VQoMjj1msUb78s1H=GfJM@mail.gmail.com>
	<AANLkTikKWrEqKH-4f2aMFnVUy-xCLnvxhtjF-pKUuC6e@mail.gmail.com>
	<AANLkTinOo9tJ5=WWF2WJEZn3VwAUOa+SOYE0txNm-moM@mail.gmail.com>
	<AANLkTim6urK-1-0MXrXZPTDWifZsi+7QEH_c8S-vzWSL@mail.gmail.com>
	<20110315171448.100300@gmx.net>
	<20110315174924.GA24001@z-innov.com>
	<20110315200855.240730@gmx.net>
	<20110315214149.GA26249@z-innov.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: ppc.addon@gmail.com, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On Tue, 15 Mar 2011 22:41:49 +0100
Sven Luther <sven.luther@z-innov.com> wrote:

> On Tue, Mar 15, 2011 at 09:08:55PM +0100, Gerhard Pircher wrote:
> > 
> > > Well, since this is long dead hardware not produced anymore, i
> > > don't see how the OF could have unbroken itself by moving to
> > > powerpc.
> > > 
> > > It has been age since i looked into this, but to the best of my
> > > knowledge (and i wrote the above code or at least the earlier
> > > versions) it should be still broken.
> > Any idea then, how the workaround can be ported to arch/powerpc/ or
> > if there is a better one available?
> 
> Sorry, it has been years since i looked these parts of the linux
> kernel, so i don't really know how the arch/powerpc code handles this
> differently. Your best guess is to hunt for the code yourself, and
> find the place. I don't remember though if debugging at that time is
> easily possible though.
> 

if chrp support doesn't anymore include Pegasos1 it could be nice to
remove all that dead code. Albeit it's fun that nobody cared about for
it during the  ppc=>powerpc switch as Pegasos1 was retired in 2003
and linux-2.6.17 was released in 2006... about three years.


my regards,
Nico
- -- 
GNU/Linux on Power Architecture
CRUX PPC - http://cruxppc.org/

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.17 (GNU/Linux)

iEYEARECAAYFAk2AAvwACgkQxq34tDeO7LiAMgCfSOueU5IE+CGJQFm56C2vIQdl
WpUAn1MsjAZb/nt1SFtfiB1gLdx79lwX
=LULL
-----END PGP SIGNATURE-----
