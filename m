Return-Path: <kato.takeharu@jp.fujitsu.com>
Received: from fgwmail6.fujitsu.co.jp (fgwmail6.fujitsu.co.jp [192.51.44.36])
	by ozlabs.org (Postfix) with ESMTP id 7DDFC67A6B
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 17 Mar 2005 11:36:52 +1100 (EST)
Message-ID: <4238D118.1000608@jp.fujitsu.com>
Date: Thu, 17 Mar 2005 09:36:40 +0900
From: Takeharu KATO <kato.takeharu@jp.fujitsu.com>
MIME-Version: 1.0
To: Tom Rini <trini@kernel.crashing.org>
References: <42331CA8.3030400@ybb.ne.jp>
	<20050316222215.GC8345@smtp.west.cox.net>
In-Reply-To: <20050316222215.GC8345@smtp.west.cox.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
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

Tom:

Sorry, I did misunderstand about it.
I'll fix this if nobody is working on this problem.

Tom Rini wrote:
> 
> 
> Are you certain that the 'time_offset' referenced in <linux/timex.h> is
> what wants to be used in arch/ppc/kernel/time.c ?  Thanks.
> 

-- 
Takeharu KATO
Fujitsu Limited
Email:kato.takeharu at jp.fujitsu.com
