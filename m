Return-Path: <trini@kernel.crashing.org>
Received: from fed1rmmtao11.cox.net (fed1rmmtao11.cox.net [68.230.241.28])
	by ozlabs.org (Postfix) with ESMTP id EAB1367A77
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 17 Mar 2005 09:22:17 +1100 (EST)
Date: Wed, 16 Mar 2005 15:22:15 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Takeharu KATO <takeharu1219@ybb.ne.jp>
Message-ID: <20050316222215.GC8345@smtp.west.cox.net>
References: <42331CA8.3030400@ybb.ne.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <42331CA8.3030400@ybb.ne.jp>
Cc: galak@freescale.com, linuxppc-embedded@ozlabs.org
Subject: Re: [PATCH] compilation failure due to confliction of time_offset
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Sun, Mar 13, 2005 at 01:45:28AM +0900, Takeharu KATO wrote:

> Hi all:
> 
> I send carbon copy of the mail to maintainers of Embedded PowerPC,
> because I can not figure out who is responsible for arch/ppc/kernel/time.c.
> 
> I found a trivial bug made compilation fail.
> I show error log as follows:
> 
> -- error log
> arch/ppc/kernel/time.c:92: error: static declaration of 'time_offset'
> follows non-static declaration
> include/linux/timex.h:236: error: previous declaration of 'time_offset'
> was heremake[1]: *** [arch/ppc/kernel/time.o] Error 1
> make: *** [arch/ppc/kernel] Error 2

Are you certain that the 'time_offset' referenced in <linux/timex.h> is
what wants to be used in arch/ppc/kernel/time.c ?  Thanks.

-- 
Tom Rini
http://gate.crashing.org/~trini/
