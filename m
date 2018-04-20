Return-Path: <npiggin@gmail.com>
Received: from mail-pf0-x243.google.com (mail-pf0-x243.google.com
 [IPv6:2607:f8b0:400e:c00::243])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40SC7x3kYFzF267
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 20 Apr 2018 20:41:17 +1000 (AEST)
Received: by mail-pf0-x243.google.com with SMTP id a2so4108444pff.8
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 20 Apr 2018 03:41:16 -0700 (PDT)
Date: Fri, 20 Apr 2018 20:41:04 +1000
From: Nicholas Piggin <npiggin@gmail.com>
To: Mathieu Malaterre <malat@debian.org>
Cc: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 linux-arch@vger.kernel.org, Nicolas Pitre <nico@fluxnic.net>,
 linux-kbuild@vger.kernel.org
Subject: Re: [PATCH 4/4] powerpc: Allow LD_DEAD_CODE_DATA_ELIMINATION to be
 selected
Message-ID: <20180420204104.6e22b136@roar.ozlabs.ibm.com>
In-Reply-To: <CA+7wUswuyn+YgNe732rQAzVmgDBohTMEqwsd76nQ_CH5h7Y5WA@mail.gmail.com>
References: <20180420073414.23169-1-npiggin@gmail.com>
 <20180420073414.23169-5-npiggin@gmail.com>
 <CA+7wUswuyn+YgNe732rQAzVmgDBohTMEqwsd76nQ_CH5h7Y5WA@mail.gmail.com>
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

On Fri, 20 Apr 2018 12:00:49 +0200
Mathieu Malaterre <malat@debian.org> wrote:

> On Fri, Apr 20, 2018 at 9:34 AM, Nicholas Piggin <npiggin@gmail.com> wrote:
> > This requires further changes to linker script to KEEP some tables
> > and wildcard compiler generated sections into the right place. This
> > includes pp32 modifications from Christophe Leroy.
> >
> > When compiling powernv_defconfig with this option:
> >
> > text       data      bss       dec        filename
> > 11827621   4810490   1341080   17979191   vmlinux
> > 11752437   4598858   1338776   17690071   vmlinux.dcde
> >
> > Resulting kernel is almost 400kB smaller (and still boots).
> >
> > [ppc32 numbers here]  
> 
> ^^^
> 
> Do you want somebody else to provide those numbers ?

If you have a booting kernel, yes some more numbers would be good.

Thanks,
Nick
