Return-Path: <arndbergmann@gmail.com>
Received: from mail-oi0-x22b.google.com (mail-oi0-x22b.google.com
 [IPv6:2607:f8b0:4003:c06::22b])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wd3kW1fYgzDq5j
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 31 May 2017 18:37:23 +1000 (AEST)
Received: by mail-oi0-x22b.google.com with SMTP id b204so7096058oii.1
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 31 May 2017 01:37:23 -0700 (PDT)
MIME-Version: 1.0
Sender: arndbergmann@gmail.com
In-Reply-To: <20170531154337.04ebcb75@canb.auug.org.au>
References: <20170531154337.04ebcb75@canb.auug.org.au>
From: Arnd Bergmann <arnd@arndb.de>
Date: Wed, 31 May 2017 10:37:20 +0200
Message-ID: <CAK8P3a3eoCTn4uDUptSreESvvQNsv9suzpuaZgq0n=-4NqFxeg@mail.gmail.com>
Subject: Re: [PATCH net-next] powerpc: use asm-generic/socket.h as much as
 possible
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: David Miller <davem@davemloft.net>, Networking <netdev@vger.kernel.org>,
 Michael Ellerman <mpe@ellerman.id.au>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 PowerPC <linuxppc-dev@lists.ozlabs.org>
Content-Type: text/plain; charset="UTF-8"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, May 31, 2017 at 7:43 AM, Stephen Rothwell <sfr@canb.auug.org.au> wrote:
> asm-generic/socket.h already has an exception for the differences that
> powerpc needs, so just include it after defining the differences.
>
> Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>

Acked-by: Arnd Bergmann <arnd@arndb.de>
