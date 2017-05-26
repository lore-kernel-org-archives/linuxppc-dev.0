Return-Path: <sfr@canb.auug.org.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wZ2Vz6B5RzDqSm
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 26 May 2017 20:31:55 +1000 (AEST)
Date: Fri, 26 May 2017 20:31:54 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Michael Ellerman <mpe@ellerman.id.au>, ppc-dev
 <linuxppc-dev@lists.ozlabs.org>
Subject: Re: [PATCH] powerpc: use the asm-genric versions of some uapi includes
Message-ID: <20170526203154.6e88cb95@canb.auug.org.au>
In-Reply-To: <CAK8P3a0QRgn2ZGQFkxwZwrpmzbQD9xtM7xg3C=eX8u=mbn9ptQ@mail.gmail.com>
References: <20170526161946.7bf423c4@canb.auug.org.au>
 <CAK8P3a0QRgn2ZGQFkxwZwrpmzbQD9xtM7xg3C=eX8u=mbn9ptQ@mail.gmail.com>
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

Hi Arnd,

On Fri, 26 May 2017 11:58:26 +0200 Arnd Bergmann <arnd@arndb.de> wrote:
>
> I think I had a patch series to do those some 10 years ago and never
> submitted it ;-)

Ah ha! :-)

> Acked-by: Arnd Bergmann <arnd@arndb.de>
> 
> asm/sockios.h is identical to the asm-generic version, so we can do
> the same there.

Yes, I see you found the next patch :-)

> asm/swab.h is functionally identical, the asm-generic version
> also has a workaround for non-gcc compilers.

I'll have a look.

> asm/socket.h would also be easy to change so we mostly use
> asm-generic, the generic version already has a special case
> for powerpc.

Yes, that is what I was aiming at, but I will submit that to the
networking tree as they have a patch to that powerpc file already which
is why I noticed at all.

-- 
Cheers,
Stephen Rothwell
