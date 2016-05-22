Return-Path: <paulus@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rCbBy5sSHzDqBv
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 23 May 2016 07:58:02 +1000 (AEST)
Date: Mon, 23 May 2016 07:57:16 +1000
From: Paul Mackerras <paulus@ozlabs.org>
To: Andrea Gelmini <andrea.gelmini@gelma.net>
Cc: trivial@kernel.org, geoff@infradead.org, benh@kernel.crashing.org,
 mpe@ellerman.id.au, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH 0218/1529] Fix typo
Message-ID: <20160522215716.GC26398@fergus.ozlabs.ibm.com>
References: <20160521120442.11309-1-andrea.gelmini@gelma.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20160521120442.11309-1-andrea.gelmini@gelma.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sat, May 21, 2016 at 02:04:42PM +0200, Andrea Gelmini wrote:
> Signed-off-by: Andrea Gelmini <andrea.gelmini@gelma.net>
> ---
>  arch/powerpc/include/asm/ps3av.h | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/powerpc/include/asm/ps3av.h b/arch/powerpc/include/asm/ps3av.h
> index 0427b0b..5176613 100644
> --- a/arch/powerpc/include/asm/ps3av.h
> +++ b/arch/powerpc/include/asm/ps3av.h
> @@ -104,7 +104,7 @@
>  #define PS3AV_CMD_AV_INPUTLEN_16			0x02
>  #define PS3AV_CMD_AV_INPUTLEN_20			0x0a
>  #define PS3AV_CMD_AV_INPUTLEN_24			0x0b
> -/* alayout */
> +/* av_layout */
>  #define PS3AV_CMD_AV_LAYOUT_32				(1 << 0)
>  #define PS3AV_CMD_AV_LAYOUT_44				(1 << 1)
>  #define PS3AV_CMD_AV_LAYOUT_48				(1 << 2)
> @@ -688,7 +688,7 @@ extern u8 ps3av_mode_cs_info[];
>  #define PS3AV_STATUS_INVALID_COMMAND		0x0003	/* obsolete invalid CID */
>  #define PS3AV_STATUS_INVALID_PORT		0x0004	/* invalid port number */
>  #define PS3AV_STATUS_INVALID_VID		0x0005	/* invalid video format */
> -#define PS3AV_STATUS_INVALID_COLOR_SPACE	0x0006	/* invalid video colose space */
> +#define PS3AV_STATUS_INVALID_COLOR_SPACE	0x0006	/* invalid video close space */

color
