Return-Path: <trini@kernel.crashing.org>
Received: from fed1rmmtao06.cox.net (fed1rmmtao06.cox.net [68.230.241.33])
	by ozlabs.org (Postfix) with ESMTP id B22772BDAB
	for <linuxppc-embedded@ozlabs.org>;
	Fri,  8 Oct 2004 01:45:58 +1000 (EST)
Date: Thu, 7 Oct 2004 08:45:57 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: "Robert P. J. Day" <rpjday@mindspring.com>
Message-ID: <20041007154557.GF14773@smtp.west.cox.net>
References: <Pine.LNX.4.60.0410060908520.8324@dell.enoriver.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <Pine.LNX.4.60.0410060908520.8324@dell.enoriver.com>
Cc: Embedded PPC Linux list <linuxppc-embedded@ozlabs.org>
Subject: Re: [PATCH] 2.6.9(?) kernel, replacing ucode patch infrastructure
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Wed, Oct 06, 2004 at 09:15:56AM -0400, Robert P. J. Day wrote:

> 
>   ok, one more time, here's a patch that should apply cleanly to the 
> latest bk repo for linuxppc-2.5.  the purpose is to create a cleaner 
> and more extensible microcode patch infrastructure, so that all you 
> need to do is *select* the 8xx-relevant patch you want from the config 
> menu under "MPC8xx" options.

This doesn't apply cleanly, even if I tell patch to ignore whitespace
changes.  Please re-generate, thanks.

-- 
Tom Rini
http://gate.crashing.org/~trini/
