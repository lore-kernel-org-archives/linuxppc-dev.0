Return-Path: <olof@lixom.net>
Received: from mail.lixom.net (lixom.net [66.141.50.11])
	by ozlabs.org (Postfix) with ESMTP id 2BD48DDFA2
	for <linuxppc-dev@ozlabs.org>; Mon, 29 Oct 2007 12:42:17 +1100 (EST)
Date: Sun, 28 Oct 2007 20:50:14 -0500
From: Olof Johansson <olof@lixom.net>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH] powerpc: Fix demotion of segments to 4K pages
Message-ID: <20071029015014.GA13687@lixom.net>
References: <1193619918.9928.0.camel@pasglop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1193619918.9928.0.camel@pasglop>
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi Ben,

On Mon, Oct 29, 2007 at 12:05:18PM +1100, Benjamin Herrenschmidt wrote:
> @@ -887,6 +886,9 @@ void hash_preload(struct mm_struct *mm, 
>  	local_irq_restore(flags);
>  }
>  
> +/* WARNING: This is called from hash_low_64.S, if you change this prototype,
> + *          do not forget to update the assembly call site !
> + */

Since we're already policing whitespace on this list today: We're normally
not using spaces before exclamation marks.


-Olof
