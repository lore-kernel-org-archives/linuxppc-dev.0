Return-Path: <olof@lixom.net>
Received: from mail.lixom.net (lixom.net [66.141.50.11])
	by ozlabs.org (Postfix) with ESMTP id CAB6B679A6
	for <linuxppc-dev@ozlabs.org>; Thu,  8 Jun 2006 03:33:56 +1000 (EST)
Date: Wed, 7 Jun 2006 10:33:20 -0700
To: Paul Mackerras <paulus@samba.org>
Subject: Re: [PATCH 2/3] powerpc: Implement support for setting little-endian
	mode via prctl
Message-ID: <20060607173320.GB5661@pb15.lixom.net>
References: <17542.28368.426967.127506@cargo.ozlabs.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <17542.28368.426967.127506@cargo.ozlabs.ibm.com>
From: Olof Johansson <olof@lixom.net>
Cc: akpm@osdl.org, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi,

On Wed, Jun 07, 2006 at 04:14:40PM +1000, Paul Mackerras wrote:

> @@ -136,6 +141,7 @@ #define CPU_FTR_COHERENT_ICACHE		ASM_CON
>  #define CPU_FTR_LOCKLESS_TLBIE		ASM_CONST(0x0)
>  #define CPU_FTR_MMCRA_SIHV		ASM_CONST(0x0)
>  #define CPU_FTR_CI_LARGE_PAGE		ASM_CONST(0x0)
> +#define CPU_FTR_PAUSE_ZERO              ASM_CONST(0x0)
>  #define CPU_FTR_PURR			ASM_CONST(0x0)
>  #endif

This seems to have snuck in from something else. It's not used anywhere.



-Olof
