Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from e32.co.us.ibm.com (e32.co.us.ibm.com [32.97.110.150])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e32.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 485C3DDF25
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 13 Aug 2007 21:19:55 +1000 (EST)
Received: from d03relay02.boulder.ibm.com (d03relay02.boulder.ibm.com
	[9.17.195.227])
	by e32.co.us.ibm.com (8.12.11.20060308/8.13.8) with ESMTP id
	l7DADErK006813
	for <linuxppc-embedded@ozlabs.org>; Mon, 13 Aug 2007 06:13:14 -0400
Received: from d03av04.boulder.ibm.com (d03av04.boulder.ibm.com [9.17.195.170])
	by d03relay02.boulder.ibm.com (8.13.8/8.13.8/NCO v8.4) with ESMTP id
	l7DBJp9l264670
	for <linuxppc-embedded@ozlabs.org>; Mon, 13 Aug 2007 05:19:51 -0600
Received: from d03av04.boulder.ibm.com (loopback [127.0.0.1])
	by d03av04.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l7DBJp6X021337
	for <linuxppc-embedded@ozlabs.org>; Mon, 13 Aug 2007 05:19:51 -0600
Date: Mon, 13 Aug 2007 06:18:54 -0500
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: joe@perches.com
Subject: Re: [PATCH] [292/2many] MAINTAINERS - LINUX FOR POWERPC EMBEDDED
	PPC4XX
Message-ID: <20070813061854.644e6e5e@zod.rchland.ibm.com>
In-Reply-To: <46bffaaf.2ObqORfh5YL/9ILj%joe@perches.com>
References: <46bffaaf.2ObqORfh5YL/9ILj%joe@perches.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: torvalds@linux-foundation.org, linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org, linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Sun, 12 Aug 2007 23:31:11 -0700
joe@perches.com wrote:

> Add file pattern to MAINTAINER entry
> 
> Signed-off-by: Joe Perches <joe@perches.com>
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 0862965..38810b7 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -2804,6 +2804,8 @@ M:	mporter@kernel.crashing.org
>  W:	http://www.penguinppc.org/
>  L:	linuxppc-embedded@ozlabs.org
>  S:	Maintained
> +F:	arch/ppc/syslib/ppc4xx_*
> +F:	include/asm-ppc/ppc4xx_*

You're missing arch/ppc/platforms/4xx/, among other things.  Also, we're
in the middle of merging 4xx to arch/powerpc.

josh
