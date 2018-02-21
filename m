Return-Path: <j.neuschaefer@gmx.net>
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zmj990Xx3zDqxr
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 22 Feb 2018 03:09:16 +1100 (AEDT)
Date: Wed, 21 Feb 2018 17:08:15 +0100
From: Jonathan =?utf-8?Q?Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
To: kbuild test robot <lkp@intel.com>
Cc: Jonathan =?utf-8?Q?Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>,
 kbuild-all@01.org, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, Michael Ellerman <mpe@ellerman.id.au>,
 linux-mm@kvack.org, Joel Stanley <joel@jms.id.au>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Thomas Gleixner <tglx@linutronix.de>,
 Philippe Ombredanne <pombredanne@nexb.com>,
 Kate Stewart <kstewart@linuxfoundation.org>,
 Nathan Fontenot <nfont@linux.vnet.ibm.com>,
 Michael Bringmann <mwb@linux.vnet.ibm.com>,
 Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>,
 Kees Cook <keescook@chromium.org>
Subject: Re: [PATCH 5/6] powerpc: Implement DISCONTIGMEM and allow selection
 on PPC32
Message-ID: <20180221160815.dxhpsejt74zeqqjd@latitude>
References: <20180220161424.5421-6-j.neuschaefer@gmx.net>
 <201802210756.OZokd64C%fengguang.wu@intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="cqenwn745jgkwtzn"
In-Reply-To: <201802210756.OZokd64C%fengguang.wu@intel.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--cqenwn745jgkwtzn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Feb 21, 2018 at 07:46:28AM +0800, kbuild test robot wrote:
[...]
> >> include/linux/mmzone.h:1239:19: error: conflicting types for 'pfn_valid'
>     static inline int pfn_valid(unsigned long pfn)
>                       ^~~~~~~~~
>    In file included from include/linux/mmzone.h:912:0,
>                     from include/linux/gfp.h:6,
>                     from include/linux/mm.h:10,
>                     from include/linux/mman.h:5,
>                     from arch/powerpc/kernel/asm-offsets.c:22:
>    arch/powerpc/include/asm/mmzone.h:40:19: note: previous definition of 'pfn_valid' was here
>     static inline int pfn_valid(int pfn)
>                       ^~~~~~~~~
>    make[2]: *** [arch/powerpc/kernel/asm-offsets.s] Error 1
>    make[2]: Target '__build' not remade because of errors.
>    make[1]: *** [prepare0] Error 2
>    make[1]: Target 'prepare' not remade because of errors.
>    make: *** [sub-make] Error 2

Oops, I'll fix this in the next version (and compile-test on ppc64...).

Weirdly enough, x86-32 and parisc define pfn_valid with an int
parameter, too (both of them since the Beginning Of Time, aka.
v2.6.12-rc2).

--cqenwn745jgkwtzn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAABAgAGBQJajZlkAAoJEAgwRJqO81/bC9EP/0FAWTZxjLN1131rfl2qXHHO
PiRFHOZgt/dlfqJQiFZSF8F33gEwQMn29NdOFqPnFyUT+9BNoBbv3RcEVNuJ2Y26
gyEVfVSINkrhqHHxtHNl+NlFsClxlo5Nrhss4gja1Jm+fZDrvFDj7YoBR1mINdbs
Wcf4OSqUjSW8ZBG1MJLli5CX5QeKpzmhiBVMKiaNEIyPaceoNZVFSIsqwTxK0LcY
ILkaUS2lAh7GF+C7vdE7/ur0U77+yPq/dc8RAw0XzzRLfAzuwt8Q12OqnoyoK598
WMcsFHF1BYs403wktKCHsLlSgQ7YfDDKq+VaJJ1kWm0FwPzAMvSkwyIUcZltAacC
c6JKm7P+CkyFkrBe/iVIGyoUSWyWAg94V4xT+UdqKz0fQxMRd0HzQNVc0q6Lwgr4
ij1ylSr+x7uuxlgPtDn1WSP5W9hGCAHcKs7g/XVMqCLXvAgElZ6edZmdSJ2wMDEJ
TRNz6LMOwUAV1ull1t+1EGOXQzKJDT/fvdeTteDjwjoc0AeycpF1x/tHreYNqaQ7
ulaG5A5tEfIZ+IxsvOjNJos1WXWG/oGwdqGcFsPgjlehtO9AEKGvlhUWcqRKItmP
LGO1oWLPejICN8Ev7eeZbJI8JFzkFcKTnZoeJjAtOIV1IOolGqfMFDKgAGVUATkM
5qCaWm6302I3zd+K6KD3
=207V
-----END PGP SIGNATURE-----

--cqenwn745jgkwtzn--
