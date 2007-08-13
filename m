Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from e35.co.us.ibm.com (e35.co.us.ibm.com [32.97.110.153])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e35.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 762C0DDE99
	for <linuxppc-dev@ozlabs.org>; Mon, 13 Aug 2007 21:17:04 +1000 (EST)
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com
	[9.17.195.106])
	by e35.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id l7DBGwST026329
	for <linuxppc-dev@ozlabs.org>; Mon, 13 Aug 2007 07:16:58 -0400
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
	by d03relay04.boulder.ibm.com (8.13.8/8.13.8/NCO v8.4) with ESMTP id
	l7DBGwCp184084
	for <linuxppc-dev@ozlabs.org>; Mon, 13 Aug 2007 05:16:58 -0600
Received: from d03av02.boulder.ibm.com (loopback [127.0.0.1])
	by d03av02.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l7DBGwaA017644
	for <linuxppc-dev@ozlabs.org>; Mon, 13 Aug 2007 05:16:58 -0600
Date: Mon, 13 Aug 2007 06:16:01 -0500
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: joe@perches.com
Subject: Re: [PATCH] [289/2many] MAINTAINERS - LINUX FOR POWERPC
Message-ID: <20070813061601.50bbefe0@zod.rchland.ibm.com>
In-Reply-To: <46bffaa9.Up0nOpoPeVCIyvqc%joe@perches.com>
References: <46bffaa9.Up0nOpoPeVCIyvqc%joe@perches.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: paulus@samba.org, akpm@linux-foundation.org, torvalds@linux-foundation.org,
	linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sun, 12 Aug 2007 23:31:05 -0700
joe@perches.com wrote:

> Add file pattern to MAINTAINER entry
> 
> Signed-off-by: Joe Perches <joe@perches.com>
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index c643ebe..1d1da70 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -2775,6 +2775,8 @@ W:	http://www.penguinppc.org/
>  L:	linuxppc-dev@ozlabs.org
>  T:	git kernel.org:/pub/scm/linux/kernel/git/paulus/powerpc.git
>  S:	Supported
> +F:	arch/powerpc
> +F:	include/asm-powerpc/

There's also the arch/ppc, include/asm-ppc directories until they get
removed.

josh
