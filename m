Return-Path: <arnd@arndb.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.183]) by ozlabs.org (Postfix) with ESMTP id 98479DE20E
	for <linuxppc-dev@ozlabs.org>; Tue, 15 Jul 2008 00:02:25 +1000 (EST)
From: Arnd Bergmann <arnd@arndb.de>
To: linuxppc-dev@ozlabs.org
Subject: Re: [PATCH] powerpc: mman.h export fixups
Date: Mon, 14 Jul 2008 16:02:15 +0200
References: <20080714170301.93f940fd.sfr@canb.auug.org.au>
	<20080714192557.331a50f5.sfr@canb.auug.org.au>
In-Reply-To: <20080714192557.331a50f5.sfr@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200807141602.15619.arnd@arndb.de>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, linux-next@vger.kernel.org,
	Dave Kleikamp <shaggy@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Monday 14 July 2008, Stephen Rothwell wrote:
> index 34a0a8d..329ecfd 100644
> --- a/include/asm-powerpc/Kbuild
> +++ b/include/asm-powerpc/Kbuild
> @@ -2,7 +2,6 @@ include include/asm-generic/Kbuild.asm
> =A0
> =A0header-y +=3D auxvec.h
> =A0header-y +=3D ioctls.h
> -header-y +=3D mman.h
> =A0header-y +=3D sembuf.h
> =A0header-y +=3D siginfo.h
> =A0header-y +=3D stat.h
> @@ -28,6 +27,7 @@ unifdef-y +=3D byteorder.h
> =A0unifdef-y +=3D cputable.h
> =A0unifdef-y +=3D elf.h
> =A0unifdef-y +=3D nvram.h
> +unifdef-y +=3D mman.h
> =A0unifdef-y +=3D param.h
> =A0unifdef-y +=3D posix_types.h
> =A0unifdef-y +=3D ptrace.h

mman.h is already listed as unifdef-y in include/asm-generic/Kbuild.asm,
so you can probably just drop it here.

	Arnd <><
