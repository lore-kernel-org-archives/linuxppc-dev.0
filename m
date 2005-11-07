Return-Path: <trini@kernel.crashing.org>
Received: from fed1rmmtao02.cox.net (fed1rmmtao02.cox.net [68.230.241.37])
	by ozlabs.org (Postfix) with ESMTP id 247B068593
	for <linuxppc-embedded@ozlabs.org>;
	Tue,  8 Nov 2005 03:22:22 +1100 (EST)
Date: Mon, 7 Nov 2005 09:22:15 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Message-ID: <20051107162215.GE3839@smtp.west.cox.net>
References: <20051104180605.GA3271@logos.cnet>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20051104180605.GA3271@logos.cnet>
Cc: Paul Mackerras <paulus@samba.org>,
	linux-ppc-embedded <linuxppc-embedded@ozlabs.org>
Subject: Re: Required functions for relocating not part of relocate section
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Fri, Nov 04, 2005 at 04:06:05PM -0200, Marcelo Tosatti wrote:

> Hi Paul,
> 
> Recent 2.6-git (from Wednesday) tree fails to boot on 8xx due to:
[snip]
> Problem is that flush_instruction_cache (and flush_data_cache)
> from boot/common/util.S are not being copied to the relocate section,
> even though the file contains the proper entry:
> 
>         .section ".relocate_code","xa"
[snip]
> The problem does not exist on v2.6.14.

What version of binutils / etc?  I recall a change in that area of code,
but I thought it went in for 2.6.14..

-- 
Tom Rini
http://gate.crashing.org/~trini/
