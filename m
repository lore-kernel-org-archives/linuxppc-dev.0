Return-Path: <shea@shealevy.com>
Received: from smtprelay.hostedemail.com (smtprelay0107.hostedemail.com
 [216.40.44.107])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40Ddvm0VhwzF1jh
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  2 Apr 2018 01:05:32 +1000 (AEST)
From: Shea Levy <shea@shealevy.com>
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, Christoph
 Hellwig <hch@infradead.org>, Richard Henderson <rth@twiddle.net>, Ivan
 Kokshaysky <ink@jurassic.park.msu.ru>, Matt Turner <mattst88@gmail.com>,
 Vineet Gupta <vgupta@synopsys.com>, Russell King <linux@armlinux.org.uk>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon
 <will.deacon@arm.com>, Mark Salter <msalter@redhat.com>, Aurelien Jacquiot
 <jacquiot.aurelien@gmail.com>, Mikael Starvik <starvik@axis.com>, Jesper
 Nilsson <jesper.nilsson@axis.com>, Yoshinori Sato
 <ysato@users.sourceforge.jp>, Richard Kuo <rkuo@codeaurora.org>, Tony Luck
 <tony.luck@intel.com>, Fenghua Yu <fenghua.yu@intel.com>, Geert
 Uytterhoeven <geert@linux-m68k.org>, James Hogan <jhogan@kernel.org>,
 Michal Simek <monstr@monstr.eu>, Ralf Baechle <ralf@linux-mips.org>, David
 Howells <dhowells@redhat.com>, Ley Foon Tan <lftan@altera.com>, Jonas Bonn
 <jonas@southpole.se>, Stefan Kristiansson
 <stefan.kristiansson@saunalahti.fi>, Stafford Horne <shorne@gmail.com>,
 "James E.J. Bottomley" <jejb@parisc-linux.org>, Helge Deller
 <deller@gmx.de>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul
 Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 Palmer Dabbelt <palmer@sifive.com>, Albert Ou <albert@sifive.com>, Martin
 Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens
 <heiko.carstens@de.ibm.com>, Chen Liqin <liqin.linux@gmail.com>, Lennox Wu
 <lennox.wu@gmail.com>, Rich Felker <dalias@libc.org>, "David S. Miller"
 <davem@davemloft.net>, Jeff Dike <jdike@addtoit.com>, Richard Weinberger
 <richard@nod.at>, Guan Xuetao <gxt@mprc.pku.edu.cn>, Thomas Gleixner
 <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin"
 <hpa@zytor.com>, x86@kernel.org, Chris Zankel <chris@zankel.net>, Max
 Filippov <jcmvbkbc@gmail.com>, Kate Stewart
 <kstewart@linuxfoundation.org>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, Philippe Ombredanne <pombredanne@nexb.com>,
 Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>, Al Viro
 <viro@zeniv.linux.org.uk>, Vladimir Murzin <vladimir.murzin@arm.com>,
 Linus Walleij <linus.walleij@linaro.org>, Michal Hocko <mhocko@suse.com>,
 Andrew Morton <akpm@linux-foundation.org>, Sudip Mukherjee
 <sudipm.mukherjee@gmail.com>, Marc Zyngier <marc.zyngier@arm.com>, Rob
 Herring <robh@kernel.org>, Kees Cook <keescook@chromium.org>, Vlastimil
 Babka <vbabka@suse.cz>, Balbir Singh <bsingharora@gmail.com>, Christophe
 Leroy <christophe.leroy@c-s.fr>, Joe Perches <joe@perches.com>, Oliver
 O'Halloran <oohall@gmail.com>, Dan Williams <dan.j.williams@intel.com>,
 Wei Yang <richard.weiyang@gmail.com>, Christian =?utf-8?Q?K=C3=B6nig?=
 <christian.koenig@amd.com>, Arnd Bergmann <arnd@arndb.de>, Deepa Dinamani
 <deepa.kernel@gmail.com>, Daniel Thompson <daniel.thompson@linaro.org>,
 Rob Landley <rob@landley.net>, Florian Fainelli <f.fainelli@gmail.com>,
 linux-alpha@vger.kernel.org, linux-snps-arc@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org,
 adi-buildroot-devel@lists.sourceforge.net, linux-c6x-dev@linux-c6x.org,
 linux-cris-kernel@axis.com, uclinux-h8-devel@lists.sourceforge.jp,
 linux-hexagon@vger.kernel.org, linux-ia64@vger.kernel.org,
 linux-m68k@lists.linux-m68k.org, linux-metag@vger.kernel.org,
 linux-mips@linux-mips.org, linux-am33-list@redhat.com,
 nios2-dev@lists.rocketboards.org, openrisc@lists.librecores.org,
 linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-s390@vger.kernel.org, linux-sh@vger.kernel.org,
 sparclinux@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net,
 user-mode-linux-user@lists.sourceforge.net, linux-xtensa@linux-xtensa.org
Subject: Re: [PATCH] Extract initrd free logic from arch-specific code.
In-Reply-To: <20180330111517.rrx6gs2skkgk336j@gmail.com>
References: <20180325221853.10839-1-shea@shealevy.com>
 <20180328152714.6103-1-shea@shealevy.com>
 <20180330111517.rrx6gs2skkgk336j@gmail.com>
Date: Sun, 01 Apr 2018 11:05:21 -0400
Message-ID: <87bmf3rmq6.fsf@xps13.shealevy.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
 micalg=pgp-sha256; protocol="application/pgp-signature"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Hi Ingo,

Ingo Molnar <mingo@kernel.org> writes:

> * Shea Levy <shea@shealevy.com> wrote:
>
>> Now only those architectures that have custom initrd free requirements
>> need to define free_initrd_mem.
>>=20
>> Signed-off-by: Shea Levy <shea@shealevy.com>
>
> Please put the Kconfig symbol name this patch introduces both into the ti=
tle, so=20
> that people know what to grep for.
>
>> ---
>>  arch/alpha/mm/init.c      |  8 --------
>>  arch/arc/mm/init.c        |  7 -------
>>  arch/arm/Kconfig          |  1 +
>>  arch/arm64/Kconfig        |  1 +
>>  arch/blackfin/Kconfig     |  1 +
>>  arch/c6x/mm/init.c        |  7 -------
>>  arch/cris/Kconfig         |  1 +
>>  arch/frv/mm/init.c        | 11 -----------
>>  arch/h8300/mm/init.c      |  7 -------
>>  arch/hexagon/Kconfig      |  1 +
>>  arch/ia64/Kconfig         |  1 +
>>  arch/m32r/Kconfig         |  1 +
>>  arch/m32r/mm/init.c       | 11 -----------
>>  arch/m68k/mm/init.c       |  7 -------
>>  arch/metag/Kconfig        |  1 +
>>  arch/microblaze/mm/init.c |  7 -------
>>  arch/mips/Kconfig         |  1 +
>>  arch/mn10300/Kconfig      |  1 +
>>  arch/nios2/mm/init.c      |  7 -------
>>  arch/openrisc/mm/init.c   |  7 -------
>>  arch/parisc/mm/init.c     |  7 -------
>>  arch/powerpc/mm/mem.c     |  7 -------
>>  arch/riscv/mm/init.c      |  6 ------
>>  arch/s390/Kconfig         |  1 +
>>  arch/score/Kconfig        |  1 +
>>  arch/sh/mm/init.c         |  7 -------
>>  arch/sparc/Kconfig        |  1 +
>>  arch/tile/Kconfig         |  1 +
>>  arch/um/kernel/mem.c      |  7 -------
>>  arch/unicore32/Kconfig    |  1 +
>>  arch/x86/Kconfig          |  1 +
>>  arch/xtensa/Kconfig       |  1 +
>>  init/initramfs.c          |  7 +++++++
>>  usr/Kconfig               |  4 ++++
>>  34 files changed, 28 insertions(+), 113 deletions(-)
>
> Please also put it into Documentation/features/.
>

I switched this patch series (the latest revision v6 was just posted) to
using weak symbols instead of Kconfig. Does it still warrant documentation?

>
>> diff --git a/usr/Kconfig b/usr/Kconfig
>> index 43658b8a975e..7a94f6df39bf 100644
>> --- a/usr/Kconfig
>> +++ b/usr/Kconfig
>> @@ -233,3 +233,7 @@ config INITRAMFS_COMPRESSION
>>  	default ".lzma" if RD_LZMA
>>  	default ".bz2"  if RD_BZIP2
>>  	default ""
>> +
>> +config HAVE_ARCH_FREE_INITRD_MEM
>> +	bool
>> +	default n
>
> Help text would be nice, to tell arch maintainers what the purpose of thi=
s switch=20
> is.
>
> Also, a nit, I think this should be named "ARCH_HAS_FREE_INITRD_MEM", whi=
ch is the=20
> dominant pattern:
>
> triton:~/tip> git grep 'select.*ARCH' arch/x86/Kconfig* | cut -f2 | cut -=
d_ -f1-2 | sort | uniq -c | sort -n
>     ...
>       2 select ARCH_USES
>       2 select ARCH_WANTS
>       3 select ARCH_MIGHT
>       3 select ARCH_WANT
>       4 select ARCH_SUPPORTS
>       4 select ARCH_USE
>      16 select HAVE_ARCH
>      23 select ARCH_HAS
>
> It also reads nicely in English:
>
>   "arch has free_initrd_mem()"
>
> While the other makes little sense:
>
>   "have arch free_initrd_mem()"
>
> ?
>
> Thanks,
>
> 	Ingo

Thanks,
Shea

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEE6ESKvwKkwnxgMLnaXAvWlX2G/icFAlrA9TEACgkQXAvWlX2G
/ieu+w/9EljMoicXq5AAY0iiZCVMRqXrkcnMT+1jcMEtLA8mLL1ibZrYLGALlTF+
+M0+7Nn2Gs9Nfna/5Mj+IW+WiQ93nFKqKWL22tBheoM6at3oZsOtX0oBI4mB9eIT
kzwUcCpCQDXvyuVbsV6XqJkCAlpYBAFE2wquWM6DVovxW91kN8cQpP3qZGtTKMkr
DMAe4LUUbM40/dDsHu43aoFb08mCct1TLf4W/CGMxSapt+8SYow7I6w1QuTJ9NYk
zTDJuV6J2xP5x4h7zPnzKA/wBkYhMrzgiMC0o3EeKWFUSa+3yCWM+dvHFzqqaz5/
jW0FUCI3mVaJgkDcdDp41mqI69WqYfpqp9LXdEjuQXRl/m9/icJL41/91XUHEfOk
k3N6HdGi7eEQ93Qo3Yv4ohr9YlK1Ah7vPK3Zq5c69k4T+sVnk5C1k/wtUkceEfGy
mgXXL9FxfFi7LpMxEpLsr8NpgkV38H1L4wanzwJGgJAeqn+bqUbhactKwl9AO7mR
u2xDrICYqEDR6bPuPHQQaF0UrsAR0uyfUGUEnuFLlTdrfgY3cpod5D+UKYCohDCC
iWuHhKxUY0SQrq99eS9oQD5JSyhqGWF61/nDzMLJ/ApFFBURUiIiW2V4NoRNMB/N
+lyDeFwyn4ApvGm5GvQlfnkaWew/0jVqx9iihclpvw3yNRSbm1M=
=FCRP
-----END PGP SIGNATURE-----
--=-=-=--
