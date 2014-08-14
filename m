Return-Path: <Vineet.Gupta1@synopsys.com>
Received: from smtprelay.synopsys.com (smtprelay.synopsys.com [198.182.44.111])
 (using TLSv1.1 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id CBEAD1A018C
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 15 Aug 2014 04:28:48 +1000 (EST)
From: Vineet Gupta <Vineet.Gupta1@synopsys.com>
To: Chen Gang <gang.chen.5i5j@gmail.com>, Arnd Bergmann <arnd@arndb.de>,
 "akpm@linux-foundation.org" <akpm@linux-foundation.org>, "rth@twiddle.net"
 <rth@twiddle.net>, "ink@jurassic.park.msu.ru" <ink@jurassic.park.msu.ru>,
 "mattst88@gmail.com" <mattst88@gmail.com>, "Vineet.Gupta1@synopsys.com"
 <Vineet.Gupta1@synopsys.com>, Geert Uytterhoeven <geert@linux-m68k.org>, Jean
 Delvare <jdelvare@suse.de>, "linux@arm.linux.org.uk"
 <linux@arm.linux.org.uk>, "catalin.marinas@arm.com"
 <catalin.marinas@arm.com>, "will.deacon@arm.com" <will.deacon@arm.com>,
 "hskinnemoen@gmail.com" <hskinnemoen@gmail.com>, "egtvedt@samfundet.no"
 <egtvedt@samfundet.no>, "realmz6@gmail.com" <realmz6@gmail.com>,
 "msalter@redhat.com" <msalter@redhat.com>, "a-jacquiot@ti.com"
 <a-jacquiot@ti.com>, "starvik@axis.com" <starvik@axis.com>,
 "jesper.nilsson@axis.com" <jesper.nilsson@axis.com>, "dhowells@redhat.com"
 <dhowells@redhat.com>, "rkuo@codeaurora.org" <rkuo@codeaurora.org>,
 "tony.luck@intel.com" <tony.luck@intel.com>, "fenghua.yu@intel.com"
 <fenghua.yu@intel.com>, "takata@linux-m32r.org" <takata@linux-m32r.org>,
 "james.hogan@imgtec.com" <james.hogan@imgtec.com>, Michal Simek
 <monstr@monstr.eu>, "ralf@linux-mips.org" <ralf@linux-mips.org>,
 "yasutake.koichi@jp.panasonic.com" <yasutake.koichi@jp.panasonic.com>,
 "jonas@southpole.se" <jonas@southpole.se>, "jejb@parisc-linux.org"
 <jejb@parisc-linux.org>, "deller@gmx.de" <deller@gmx.de>, "Benjamin
 Herrenschmidt" <benh@kernel.crashing.org>, "paulus@samba.org"
 <paulus@samba.org>, "mpe@ellerman.id.au" <mpe@ellerman.id.au>, "Martin
 Schwidefsky" <schwidefsky@de.ibm.com>, "heiko.carstens@de.ibm.com"
 <heiko.carstens@de.ibm.com>, Liqin Chen <liqin.linux@gmail.com>, Lennox Wu
 <lennox.wu@gmail.com>, "David S. Miller" <davem@davemloft.net>,
 "cmetcalf@tilera.com" <cmetcalf@tilera.com>, "jdike@addtoit.com"
 <jdike@addtoit.com>, Richard Weinberger <richard@nod.at>,
 "gxt@mprc.pku.edu.cn" <gxt@mprc.pku.edu.cn>, "tglx@linutronix.de"
 <tglx@linutronix.de>, "mingo@redhat.com" <mingo@redhat.com>, "hpa@zytor.com"
 <hpa@zytor.com>, "chris@zankel.net" <chris@zankel.net>, "jcmvbkbc@gmail.com"
 <jcmvbkbc@gmail.com>
Subject: Re: [PATCH v3] arch: Kconfig: Let all architectures set endian
 explicitly
Date: Thu, 14 Aug 2014 18:21:43 +0000
Message-ID: <C2D7FE5348E1B147BCA15975FBA230753C4BA528@IN01WEMBXA.internal.synopsys.com>
References: <53ECE9DD.80004@gmail.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Cc: "linux-m32r-ja@ml.linux-m32r.org" <linux-m32r-ja@ml.linux-m32r.org>,
 "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
 "linux-ia64@vger.kernel.org" <linux-ia64@vger.kernel.org>,
 "linux@lists.openrisc.net" <linux@lists.openrisc.net>,
 "sparclinux@vger.kernel.org" <sparclinux@vger.kernel.org>,
 "linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>,
 "linux-am33-list@redhat.com" <linux-am33-list@redhat.com>,
 "linux-c6x-dev@linux-c6x.org" <linux-c6x-dev@linux-c6x.org>,
 "linux-hexagon@vger.kernel.org" <linux-hexagon@vger.kernel.org>,
 "x86@kernel.org" <x86@kernel.org>,
 "linux-xtensa@linux-xtensa.org" <linux-xtensa@linux-xtensa.org>,
 "user-mode-linux-devel@lists.sourceforge.net"
 <user-mode-linux-devel@lists.sourceforge.net>,
 "adi-buildroot-devel@lists.sourceforge.net"
 <adi-buildroot-devel@lists.sourceforge.net>,
 "linux-m68k@lists.linux-m68k.org" <linux-m68k@lists.linux-m68k.org>,
 "user-mode-linux-user@lists.sourceforge.net"
 <user-mode-linux-user@lists.sourceforge.net>,
 "linux-metag@vger.kernel.org" <linux-metag@vger.kernel.org>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
 "linux-m32r@ml.linux-m32r.org" <linux-m32r@ml.linux-m32r.org>,
 "linux-parisc@vger.kernel.org" <linux-parisc@vger.kernel.org>,
 "linux-cris-kernel@axis.com" <linux-cris-kernel@axis.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-alpha@vger.kernel.org" <linux-alpha@vger.kernel.org>,
 "linux390@de.ibm.com" <linux390@de.ibm.com>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thursday 14 August 2014 09:55 AM, Chen Gang wrote:=0A=
> Normal architectures:=0A=
>=0A=
>  - Big endian: avr32, frv, m68k, openrisc, parisc, s390, sparc=0A=
>=0A=
>  - Little endian: alpha, blackfin, cris, hexagon, ia64, metag, mn10300,=
=0A=
>                   score, unicore32, x86=0A=
>=0A=
>  - Choose in config time: arc, arm, arm64, c6x, m32r, mips, powerpc, sh=
=0A=
>=0A=
> Special architectures:=0A=
>=0A=
>  - Deside by compiler: microblaze, tile, xtensa.=0A=
>=0A=
>  - Deside by building host: um=0A=
>=0A=
>  - Next, need improve Kbuild to probe endian to deside whether need mark=
=0A=
>    __BUILDING_TIME_BIG_ENDIAN__ before real config.=0A=
>=0A=
> Another improvements:=0A=
>=0A=
>  - score: use '\t' instead of ' '.=0A=
>=0A=
>  - s390: sort the select value in alpha order.=0A=
>=0A=
> Signed-off-by: Chen Gang <gang.chen.5i5j@gmail.com>=0A=
> ---=0A=
>  arch/alpha/Kconfig      |  1 +=0A=
>  arch/arc/Kconfig        |  1 +=0A=
>  arch/arm/Kconfig        |  1 +=0A=
>  arch/arm64/Kconfig      |  1 +=0A=
>  arch/avr32/Kconfig      |  1 +=0A=
>  arch/blackfin/Kconfig   |  1 +=0A=
>  arch/c6x/Kconfig        |  1 +=0A=
>  arch/cris/Kconfig       |  1 +=0A=
>  arch/frv/Kconfig        |  1 +=0A=
>  arch/hexagon/Kconfig    |  1 +=0A=
>  arch/ia64/Kconfig       |  1 +=0A=
>  arch/m32r/Kconfig       |  1 +=0A=
>  arch/m68k/Kconfig       |  1 +=0A=
>  arch/metag/Kconfig      |  1 +=0A=
>  arch/microblaze/Kconfig |  2 ++=0A=
>  arch/mips/Kconfig       |  1 +=0A=
>  arch/mn10300/Kconfig    |  1 +=0A=
>  arch/openrisc/Kconfig   |  1 +=0A=
>  arch/parisc/Kconfig     |  1 +=0A=
>  arch/powerpc/Kconfig    |  1 +=0A=
>  arch/s390/Kconfig       |  3 ++-=0A=
>  arch/score/Kconfig      | 21 +++++++++++----------=0A=
>  arch/sparc/Kconfig      |  1 +=0A=
>  arch/tile/Kconfig       |  2 ++=0A=
>  arch/um/Kconfig.common  |  2 ++=0A=
>  arch/unicore32/Kconfig  |  1 +=0A=
>  arch/x86/Kconfig        |  1 +=0A=
>  arch/xtensa/Kconfig     |  2 ++=0A=
>  init/Kconfig            |  6 ++++++=0A=
>  29 files changed, 49 insertions(+), 11 deletions(-)=0A=
>=0A=
> diff --git a/arch/alpha/Kconfig b/arch/alpha/Kconfig=0A=
> index b7ff9a3..1cb7426 100644=0A=
> --- a/arch/alpha/Kconfig=0A=
> +++ b/arch/alpha/Kconfig=0A=
> @@ -27,6 +27,7 @@ config ALPHA=0A=
>  	select MODULES_USE_ELF_RELA=0A=
>  	select ODD_RT_SIGACTION=0A=
>  	select OLD_SIGSUSPEND=0A=
> +	select CPU_LITTLE_ENDIAN=0A=
>  	help=0A=
>  	  The Alpha is a 64-bit general-purpose processor designed and=0A=
>  	  marketed by the Digital Equipment Corporation of blessed memory,=0A=
> diff --git a/arch/arc/Kconfig b/arch/arc/Kconfig=0A=
> index 9596b0a..e939abd 100644=0A=
> --- a/arch/arc/Kconfig=0A=
> +++ b/arch/arc/Kconfig=0A=
> @@ -35,6 +35,7 @@ config ARC=0A=
>  	select OF_EARLY_FLATTREE=0A=
>  	select PERF_USE_VMALLOC=0A=
>  	select HAVE_DEBUG_STACKOVERFLOW=0A=
> +	select CPU_LITTLE_ENDIAN if !CPU_BIG_ENDIAN=0A=
=0A=
It is not clear what exactly are you trying to fix. What doesn't work w/o t=
his=0A=
patch !=0A=
=0A=
-Vineet=0A=
