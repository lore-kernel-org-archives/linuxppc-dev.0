Return-Path: <arndbergmann@gmail.com>
Received: from mail-oi0-x243.google.com (mail-oi0-x243.google.com
 [IPv6:2607:f8b0:4003:c06::243])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wZ1mP22QBzDqTf
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 26 May 2017 19:58:29 +1000 (AEST)
Received: by mail-oi0-x243.google.com with SMTP id h4so938113oib.0
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 26 May 2017 02:58:29 -0700 (PDT)
MIME-Version: 1.0
Sender: arndbergmann@gmail.com
In-Reply-To: <20170526161946.7bf423c4@canb.auug.org.au>
References: <20170526161946.7bf423c4@canb.auug.org.au>
From: Arnd Bergmann <arnd@arndb.de>
Date: Fri, 26 May 2017 11:58:26 +0200
Message-ID: <CAK8P3a0QRgn2ZGQFkxwZwrpmzbQD9xtM7xg3C=eX8u=mbn9ptQ@mail.gmail.com>
Subject: Re: [PATCH] powerpc: use the asm-genric versions of some uapi includes
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: Michael Ellerman <mpe@ellerman.id.au>,
 ppc-dev <linuxppc-dev@lists.ozlabs.org>
Content-Type: text/plain; charset="UTF-8"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, May 26, 2017 at 8:19 AM, Stephen Rothwell <sfr@canb.auug.org.au> wrote:
> These are completely obvious as all they do is include the asm-generic
> versions.
>
> Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>

I think I had a patch series to do those some 10 years ago and never
submitted it ;-)

Acked-by: Arnd Bergmann <arnd@arndb.de>

asm/sockios.h is identical to the asm-generic version, so we can do
the same there.

asm/swab.h is functionally identical, the asm-generic version
also has a workaround for non-gcc compilers.

asm/socket.h would also be easy to change so we mostly use
asm-generic, the generic version already has a special case
for powerpc.
