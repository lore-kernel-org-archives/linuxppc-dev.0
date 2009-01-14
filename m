Return-Path: <Geoffrey.Levand@am.sony.com>
Message-ID: <496E6CE2.2050004@am.sony.com>
Date: Wed, 14 Jan 2009 14:53:22 -0800
From: Geoff Levand <geoffrey.levand@am.sony.com>
MIME-Version: 1.0
To: Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: [PATCH 03/13] powerpc/ps3: the lv1_ routines have u64 parameters
References: <20090114165450.ebbc11a7.sfr@canb.auug.org.au>
	<20090114165941.a3145499.sfr@canb.auug.org.au>
In-Reply-To: <20090114165941.a3145499.sfr@canb.auug.org.au>
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
> We just fix up the reference parameters as the others are dealt with by
> arithmetic promotion rules and don't cause warnings.
> 
> This removes warnings like this:
> 
> arch/powerpc/platforms/ps3/interrupt.c:327: warning: passing argument 1 of 'lv1_construct_event_receive_port' from incompatible pointer type
> 
> Also, these:
> 
> drivers/ps3/ps3-vuart.c:462: warning: passing argument 4 of 'ps3_vuart_raw_read' from incompatible pointer type
> drivers/ps3/ps3-vuart.c:592: warning: passing argument 4 of 'ps3_vuart_raw_read' from incompatible pointer type
> 
> Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
> ---
>  arch/powerpc/platforms/ps3/interrupt.c  |    8 +++---
>  arch/powerpc/platforms/ps3/mm.c         |   38 +++++++++++++++++-------------
>  arch/powerpc/platforms/ps3/spu.c        |   12 ++++++---
>  arch/powerpc/platforms/ps3/system-bus.c |    4 ++-
>  drivers/ps3/ps3-vuart.c                 |   24 ++++++++++---------
>  5 files changed, 49 insertions(+), 37 deletions(-)

Acked-by: Geoff Levand <geoffrey.levand@am.sony.com>
