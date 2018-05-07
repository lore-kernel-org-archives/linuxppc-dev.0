Return-Path: <npiggin@gmail.com>
Received: from mail-pg0-x236.google.com (mail-pg0-x236.google.com
 [IPv6:2607:f8b0:400e:c05::236])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40fdGw29rdzF151
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  7 May 2018 19:53:28 +1000 (AEST)
Received: by mail-pg0-x236.google.com with SMTP id i29-v6so19825407pgn.12
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 07 May 2018 02:53:28 -0700 (PDT)
Date: Mon, 7 May 2018 19:53:14 +1000
From: Nicholas Piggin <npiggin@gmail.com>
To: Masahiro Yamada <yamada.masahiro@socionext.com>
Cc: Mathieu Malaterre <malat@debian.org>, linuxppc-dev
 <linuxppc-dev@lists.ozlabs.org>, linux-arch <linux-arch@vger.kernel.org>,
 Nicolas Pitre <nico@fluxnic.net>, Linux Kbuild mailing list
 <linux-kbuild@vger.kernel.org>
Subject: Re: [PATCH 4/4] powerpc: Allow LD_DEAD_CODE_DATA_ELIMINATION to be
 selected
Message-ID: <20180507195314.6711f3b8@roar.ozlabs.ibm.com>
In-Reply-To: <CAK7LNASvOwam=AhN11sUKvBbtJbBzQULqs8kRV2KRS45jbSLcQ@mail.gmail.com>
References: <20180420073414.23169-1-npiggin@gmail.com>
 <20180420073414.23169-5-npiggin@gmail.com>
 <CA+7wUswuyn+YgNe732rQAzVmgDBohTMEqwsd76nQ_CH5h7Y5WA@mail.gmail.com>
 <20180420204104.6e22b136@roar.ozlabs.ibm.com>
 <CAK7LNASvOwam=AhN11sUKvBbtJbBzQULqs8kRV2KRS45jbSLcQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 7 May 2018 09:46:43 +0900
Masahiro Yamada <yamada.masahiro@socionext.com> wrote:

> Hi Nicholas,
> 
> 2018-04-20 19:41 GMT+09:00 Nicholas Piggin <npiggin@gmail.com>:
> > On Fri, 20 Apr 2018 12:00:49 +0200
> > Mathieu Malaterre <malat@debian.org> wrote:
> >  
> >> On Fri, Apr 20, 2018 at 9:34 AM, Nicholas Piggin <npiggin@gmail.com> wrote:  
> >> > This requires further changes to linker script to KEEP some tables
> >> > and wildcard compiler generated sections into the right place. This
> >> > includes pp32 modifications from Christophe Leroy.
> >> >
> >> > When compiling powernv_defconfig with this option:
> >> >
> >> > text       data      bss       dec        filename
> >> > 11827621   4810490   1341080   17979191   vmlinux
> >> > 11752437   4598858   1338776   17690071   vmlinux.dcde
> >> >
> >> > Resulting kernel is almost 400kB smaller (and still boots).
> >> >
> >> > [ppc32 numbers here]  
> >>
> >> ^^^
> >>
> >> Do you want somebody else to provide those numbers ?  
> >
> > If you have a booting kernel, yes some more numbers would be good.
> >
> > Thanks,
> > Nick  
> 
> 
> 
> I applied this series because I want it to be more tested in linux-next.

Thank you.


> Some requests:
> 
>  - Could you provide information to replace '[ppc32 numbers here]'?
>    (or just remove it)

Yes there were some numbers reported, I can give you an updated
changelog.

>  - V2 is welcome if you have code improvement.
>    (I thought so from your comments)

I'll see where it ended up and send you updated patches if necessary.

Thanks,
Nick
