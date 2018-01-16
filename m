Return-Path: <jk@ozlabs.org>
Received: from ozlabs.org (bilbo.ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zLfqR4KWhzF0cW
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 17 Jan 2018 06:07:31 +1100 (AEDT)
Subject: Re: [PATCH] [RESEND] spufs: use timespec64 for timestamps
To: Arnd Bergmann <arnd@arndb.de>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>
Cc: Al Viro <viro@zeniv.linux.org.uk>,
 Andrew Morton <akpm@linux-foundation.org>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
References: <20180116170053.2557047-1-arnd@arndb.de>
From: Jeremy Kerr <jk@ozlabs.org>
Message-ID: <1dc0e4ce-2190-eb83-166f-b8ba7cdacede@ozlabs.org>
Date: Tue, 16 Jan 2018 13:07:24 -0600
MIME-Version: 1.0
In-Reply-To: <20180116170053.2557047-1-arnd@arndb.de>
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Arnd,

> The switch log prints the tv_sec portion of timespec as a 32-bit
> number, while overflows in 2106. It also uses the timespec type,
> which is safe on 64-bit architectures, but deprecated because
> it causes overflows in 2038 elsewhere.
> 
> This changes it to timespec64 and printing a 64-bit number for
> consistency.

If we still have spufs in the tree in 2038 I'd be worried :) But good
to keep things consistent.

Acked-by: Jeremy Kerr <jk@ozlabs.org>

Michael: want to take this directly through your tree?

Cheers,


Jeremy
