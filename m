Return-Path: <sfr@canb.auug.org.au>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wZ2Wn58QZzDqWj
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 26 May 2017 20:32:37 +1000 (AEST)
Date: Fri, 26 May 2017 20:32:36 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Michael Ellerman <mpe@ellerman.id.au>, ppc-dev
 <linuxppc-dev@lists.ozlabs.org>
Subject: Re: [PATCH] powerpc: use uapi/asm-generic/sockios.h
Message-ID: <20170526203236.020dacc9@canb.auug.org.au>
In-Reply-To: <CAK8P3a1r7xO0Trwt-ASUAra9Zmh68oeEodbrBPf7=qUgsBDUTA@mail.gmail.com>
References: <20170526161946.7bf423c4@canb.auug.org.au>
 <20170526183229.193ef0eb@canb.auug.org.au>
 <CAK8P3a1r7xO0Trwt-ASUAra9Zmh68oeEodbrBPf7=qUgsBDUTA@mail.gmail.com>
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

On Fri, 26 May 2017 11:59:23 +0200 Arnd Bergmann <arnd@arndb.de> wrote:
>
> On Fri, May 26, 2017 at 10:32 AM, Stephen Rothwell <sfr@canb.auug.org.au> wrote:
> > Hi all,
> >
> > The arch version is identical except for comments and white space.
> >
> > Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>  
> 
> Acked-by: Arnd Bergmann <arnd@arndb.de>

Thanks.

-- 
Cheers,
Stephen Rothwell
