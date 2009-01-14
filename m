Return-Path: <Geoffrey.Levand@am.sony.com>
Message-ID: <496E6CD5.7090408@am.sony.com>
Date: Wed, 14 Jan 2009 14:53:09 -0800
From: Geoff Levand <geoffrey.levand@am.sony.com>
MIME-Version: 1.0
To: Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: [PATCH 02/13] powerpc/ps3: use dma_addr_t down through the stack
References: <20090114165450.ebbc11a7.sfr@canb.auug.org.au>
	<20090114165810.a6a6c3ab.sfr@canb.auug.org.au>
In-Reply-To: <20090114165810.a6a6c3ab.sfr@canb.auug.org.au>
Content-Type: text/plain; charset="ISO-8859-1"
Cc: ppc-dev <linuxppc-dev@ozlabs.org>, cbe-oss-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Stephen Rothwell wrote:
> Push the dma_addr_t type usage all the way down to where the actual
> values are manipulated.
> 
> Now that u64 is "unsigned long long", this removes warnings like:
> 
> arch/powerpc/platforms/ps3/system-bus.c:532: warning: passing argument 4 of 'ps3_dma_map' from incompatible pointer type
> arch/powerpc/platforms/ps3/system-bus.c:649: warning: passing argument 4 of 'ps3_dma_map' from incompatible pointer type
> 
> Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
> ---
>  arch/powerpc/include/asm/ps3.h          |    8 +++---
>  arch/powerpc/platforms/ps3/mm.c         |   32 ++++++++++++++++--------------
>  arch/powerpc/platforms/ps3/system-bus.c |    4 +-
>  3 files changed, 23 insertions(+), 21 deletions(-)

Acked-by: Geoff Levand <geoffrey.levand@am.sony.com>
