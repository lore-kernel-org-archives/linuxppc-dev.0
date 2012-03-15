Return-Path: <sfr@canb.auug.org.au>
Received: from members.tip.net.au (haggis.tip.net.au
 [IPv6:2402:b800:7003:1::20])
 by ozlabs.org (Postfix) with ESMTP id 6E785B6EF4
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 16 Mar 2012 09:11:28 +1100 (EST)
Date: Fri, 16 Mar 2012 09:11:21 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: David Howells <dhowells@redhat.com>
Subject: Re: [PATCH 21/38] Disintegrate asm/system.h for PowerPC [ver #3]
Message-Id: <20120316091121.1a204465647258dddc3bd89d@canb.auug.org.au>
In-Reply-To: <20120315205831.28759.61679.stgit@warthog.procyon.org.uk>
References: <20120315205514.28759.58969.stgit@warthog.procyon.org.uk>
 <20120315205831.28759.61679.stgit@warthog.procyon.org.uk>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="PGP-SHA256";
 boundary="Signature=_Fri__16_Mar_2012_09_11_21_+1100_WMGSzLZFfEeAgF2D"
Cc: linux-arch@vger.kernel.org, paul.gortmaker@windriver.com,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org, arnd@arndb.de
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--Signature=_Fri__16_Mar_2012_09_11_21_+1100_WMGSzLZFfEeAgF2D
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Dave,

On Thu, 15 Mar 2012 20:58:32 +0000 David Howells <dhowells@redhat.com> wrot=
e:
>
>  arch/powerpc/platforms/iseries/dt.c               |    1=20
>  arch/powerpc/platforms/iseries/lpevents.c         |    1=20
>  arch/powerpc/platforms/iseries/setup.c            |    1=20
>  arch/powerpc/platforms/iseries/smp.c              |    1=20
>  arch/powerpc/platforms/iseries/viopath.c          |    1=20

I don't expect you to change your series (now, anyway), but just a heads
up that all those files have been removed in the powerpc tree.

--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

--Signature=_Fri__16_Mar_2012_09_11_21_+1100_WMGSzLZFfEeAgF2D
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBCAAGBQJPYmkJAAoJEECxmPOUX5FEULUP/1AR0SltRXfg2mLEuZhgz/cc
QaRqQ3PaCIkMI6pO6Ykgib8t69V4pFl/NJn4BTK1TzY/9q0Ljo7Olq6K1ZSQ86zk
8l8Pmx1jsOpFO5vvIcf7bMOiSiu95PNPSurzfulgxzkcXn3eNHO2Egr05pC06mML
ZZHUgsxLA50s0hDuZZ3dHrl3qwiwnCZwe/MSioToya4y06FEB1o0x8Kf5gGXQCT2
wQ9DfrL6JnRMkaRvJQSAtX0MHqoE0wSpuaI6aHQ+cwXud1Vcbs+ui42VoDlwp7Gm
IDfsqx6S7W/7uFKITvYk+OBQc5/OmUftoS5VH1MbReSp0E17QC0DVSAUy860xLZe
IfkfdtRXHqd7XmcbGHniKwi+TaVe8haADMsns/l6PY3IQCTKJ3LlKLmbB58gdJkE
opaT32F0Spb34T6GWXOvFFKcADCJSsL07wES59+DlFnE4S76xOamCNkI/0B80V+c
Fz7s8pCfoWe0+FZYMNt2h269EtrYgAo01ySMpGzn1ajQcf5fmXVS/iINmTn3eTyE
tCAWY/2ttab0bnRy/ZkSZNLEOXnfR/snTQ/gDXmWrtMzsqDEBC/n3dsmOqyhhsuS
DQH+TYf911LdUJVwr8VbG+qHrPXkDeEeW4vso/Ie1MLYRPX9kPhwaP0Ak2qn3vCp
dtCEubzdflNaioMLlC8S
=mdZk
-----END PGP SIGNATURE-----

--Signature=_Fri__16_Mar_2012_09_11_21_+1100_WMGSzLZFfEeAgF2D--
