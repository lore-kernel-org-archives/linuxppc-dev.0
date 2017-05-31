Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wd5wF0H7TzDq5j
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 31 May 2017 20:15:57 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Stephen Rothwell <sfr@canb.auug.org.au>, David Miller <davem@davemloft.net>,
 Networking <netdev@vger.kernel.org>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 PowerPC <linuxppc-dev@lists.ozlabs.org>, Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH net-next] powerpc: use asm-generic/socket.h as much as
 possible
In-Reply-To: <20170531154337.04ebcb75@canb.auug.org.au>
References: <20170531154337.04ebcb75@canb.auug.org.au>
Date: Wed, 31 May 2017 20:15:55 +1000
Message-ID: <878tld49ic.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Stephen Rothwell <sfr@canb.auug.org.au> writes:

> asm-generic/socket.h already has an exception for the differences that
> powerpc needs, so just include it after defining the differences.
>
> Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
> ---
>  arch/powerpc/include/uapi/asm/socket.h | 92 +---------------------------------
>  1 file changed, 1 insertion(+), 91 deletions(-)
>
> Build tested using powerpc allyesconfig, pseries_le_defconfig, 32 bit
> and 64 bit allnoconfig and ppc44x_defconfig builds.

Did you boot it and test that userspace was happy doing sockety things?

cheers
