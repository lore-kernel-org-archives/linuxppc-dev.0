Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zPxr76BdNzF0X2
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 22 Jan 2018 14:34:31 +1100 (AEDT)
In-Reply-To: <20180116170053.2557047-1-arnd@arndb.de>
To: Arnd Bergmann <arnd@arndb.de>, Jeremy Kerr <jk@ozlabs.org>,
 Arnd Bergmann <arnd@arndb.de>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: Andrew Morton <akpm@linux-foundation.org>, linuxppc-dev@lists.ozlabs.org,
 Al Viro <viro@zeniv.linux.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: [RESEND] spufs: use timespec64 for timestamps
Message-Id: <3zPxr24b0Yz9sP9@ozlabs.org>
Date: Mon, 22 Jan 2018 14:34:25 +1100 (AEDT)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2018-01-16 at 17:00:35 UTC, Arnd Bergmann wrote:
> The switch log prints the tv_sec portion of timespec as a 32-bit
> number, while overflows in 2106. It also uses the timespec type,
> which is safe on 64-bit architectures, but deprecated because
> it causes overflows in 2038 elsewhere.
> 
> This changes it to timespec64 and printing a 64-bit number for
> consistency.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> Acked-by: Jeremy Kerr <jk@ozlabs.org>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/cef37ac119b1abffcb41a9a7067929

cheers
