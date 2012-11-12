Return-Path: <B07421@freescale.com>
Received: from co1outboundpool.messaging.microsoft.com
 (co1ehsobe004.messaging.microsoft.com [216.32.180.187])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 0E3702C0081
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 13 Nov 2012 08:51:22 +1100 (EST)
Date: Mon, 12 Nov 2012 15:51:06 -0600
From: Scott Wood <scottwood@freescale.com>
Subject: Re: Build regressions/improvements in v3.7-rc5
To: Geert Uytterhoeven <geert@linux-m68k.org>
In-Reply-To: <CAMuHMdXE0yJNivpirGgx08zqLH2086ydeOU6zswXj-+zn8OsWQ@mail.gmail.com>
 (from geert@linux-m68k.org on Mon Nov 12 15:02:46 2012)
Message-ID: <1352757066.32153.5@snotra>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; delsp=Yes; format=Flowed
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 11/12/2012 03:02:46 PM, Geert Uytterhoeven wrote:
> On Mon, Nov 12, 2012 at 9:58 PM, Geert Uytterhoeven
> <geert@linux-m68k.org> wrote:
> > JFYI, when comparing v3.7-rc5 to v3.7-rc4[3], the summaries are:
> >   - build errors: +14/-4
>=20
> 14 regressions:
>   + drivers/virt/fsl_hypervisor.c: error: 'MSR_GS' undeclared (first
> use in this function):  =3D> 799:93

These reports would be more useful if the actual .config were provided, =20
rather than just saying "powerpc randconfig".

I doubt this particular one is a regression; it looks like the =20
dependencies have always been too weak (patch sent) and you're just =20
comparing different randomly-generated configs.

> powerpc-randconfig
>=20
>   + error: relocation truncated to fit: R_PPC64_REL24 against symbol
> `._mcount' defined in .text section in arch/powerpc/kernel/entry_64.o:
> (.text+0x1ff9eb8) =3D> (.text+0x1ffa274), (.text+0x1ff7840)
>=20
> powerpc-allyesconfig

It's been over 3 years since powerpc-allyesconfig built (it's just too =20
big for the relocation model the kernel uses) -- how is this a =20
regression?

-Scott=
