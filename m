Return-Path: <arndbergmann@gmail.com>
Received: from mail-oi0-x243.google.com (mail-oi0-x243.google.com
 [IPv6:2607:f8b0:4003:c06::243])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wZ1nT3HBfzDqTj
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 26 May 2017 19:59:25 +1000 (AEST)
Received: by mail-oi0-x243.google.com with SMTP id w10so939704oif.1
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 26 May 2017 02:59:25 -0700 (PDT)
MIME-Version: 1.0
Sender: arndbergmann@gmail.com
In-Reply-To: <20170526183229.193ef0eb@canb.auug.org.au>
References: <20170526161946.7bf423c4@canb.auug.org.au>
 <20170526183229.193ef0eb@canb.auug.org.au>
From: Arnd Bergmann <arnd@arndb.de>
Date: Fri, 26 May 2017 11:59:23 +0200
Message-ID: <CAK8P3a1r7xO0Trwt-ASUAra9Zmh68oeEodbrBPf7=qUgsBDUTA@mail.gmail.com>
Subject: Re: [PATCH] powerpc: use uapi/asm-generic/sockios.h
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

On Fri, May 26, 2017 at 10:32 AM, Stephen Rothwell <sfr@canb.auug.org.au> wrote:
> Hi all,
>
> The arch version is identical except for comments and white space.
>
> Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>

Acked-by: Arnd Bergmann <arnd@arndb.de>
