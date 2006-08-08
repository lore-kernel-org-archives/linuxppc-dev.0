Return-Path: <miltonm@bga.com>
Received: from ruth.realtime.net (mercury.realtime.net [205.238.132.86])
	by ozlabs.org (Postfix) with ESMTP id 2D9BE67A3D
	for <linuxppc-dev@ozlabs.org>; Tue,  8 Aug 2006 11:24:05 +1000 (EST)
Date: Mon, 7 Aug 2006 20:22:23 -0500
From: Milton Miller <miltonm@bga.com>
To: mikey@neuling.org, paulus@samba.org
Subject: Re: [PATCH] Update lppaca offset comments
Message-Id: <311550001426b8b45674.1681692777.miltonm@bga.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon Aug  7 2006 02:34:50 AM CDT, Michael Neuling wrote:
> Update offset comments.  No functional change. 
> 
> Signed-off-by: Michael Neuling <mikey@neuling.org>
> ---
>  include/asm-powerpc/lppaca.h |    4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> Index: linux-2.6-ozlabs/include/asm-powerpc/lppaca.h
> ===================================================================
> --- linux-2.6-ozlabs.orig/include/asm-powerpc/lppaca.h
> +++ linux-2.6-ozlabs/include/asm-powerpc/lppaca.h
> @@ -114,7 +114,7 @@ struct lppaca {
>  
>  
>  //=============================================================================
> -// CACHE_LINE_3 0x0100 - 0x007F: This line is shared with other processors
> +// CACHE_LINE_3 0x0100 - 0x017F: This line is shared with other processors
>  //=============================================================================
 
How about taking the opertunity  to convert to C comments?

milton
