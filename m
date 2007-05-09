Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id 9AD6ADDEF6
	for <linuxppc-dev@ozlabs.org>; Thu, 10 May 2007 02:32:21 +1000 (EST)
Date: Thu, 10 May 2007 02:32:21 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 1/2] Declare {compat_}sys_utimensat
Message-Id: <20070510023221.92cefc44.sfr@canb.auug.org.au>
In-Reply-To: <200705091821.59412.arnd@arndb.de>
References: <20070509162357.65ab8868.sfr@canb.auug.org.au>
	<200705091821.59412.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
	micalg="PGP-SHA1";
	boundary="Signature=_Thu__10_May_2007_02_32_21_+1000_r2daT+IAQC2kIIF8"
Cc: linuxppc-dev@ozlabs.org, Andrew Morton <akpm@linux-foundation.org>,
	Linus <torvalds@linux-foundation.org>, paulus@samba.org,
	LKML <linux-kernel@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--Signature=_Thu__10_May_2007_02_32_21_+1000_r2daT+IAQC2kIIF8
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: 7bit

On Wed, 9 May 2007 18:21:58 +0200 Arnd Bergmann <arnd@arndb.de> wrote:
>
> It seems bogus to declare compat_sys_futimesat in syscalls.h and
> compat_sys_utimensat in compat.h. Your patch is fine, since there
> are precedents for both, but maybe we should agree on one place and
> then move all of the compat_sys_ declarations there.

My preference is to split them like this so that the architectures that
don't need the compat infrastructure are not cluttered with it (if we
declare the compat routines in syscalls.h, then it should include
compat.h).

--
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

--Signature=_Thu__10_May_2007_02_32_21_+1000_r2daT+IAQC2kIIF8
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFGQfebFdBgD/zoJvwRAvWgAJ45hx0WnJX4UVNLjwayDfsw/OYJtwCeId95
T9bIdwQlcO7cONtY73QikE8=
=yBfc
-----END PGP SIGNATURE-----

--Signature=_Thu__10_May_2007_02_32_21_+1000_r2daT+IAQC2kIIF8--
