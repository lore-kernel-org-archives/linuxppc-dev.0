Return-Path: <trini@kernel.crashing.org>
Received: from fed1rmmtao06.cox.net (fed1rmmtao06.cox.net [68.230.241.33])
	by ozlabs.org (Postfix) with ESMTP id 6D3CA2BE83
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 16 Dec 2004 01:35:20 +1100 (EST)
Date: Wed, 15 Dec 2004 07:35:18 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: tglx@linutronix.de
Message-ID: <20041215143518.GC22316@smtp.west.cox.net>
References: <20041215152142.1.patchmail@tglx>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20041215152142.1.patchmail@tglx>
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: [PATCH] Compile 6xx specific code only for 6xx machines
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Wed, Dec 15, 2004 at 03:21:43PM +0100, tglx@linutronix.de wrote:

> The 6xx specific mmu functions in arch/boot/common/util.S break the compile for
> other platforms. Compile them for 6xx only.

They, er, do?  Can you please post a log?  And what toolchain are you
using?  I'd make a quick guess that the binutils folks are being overly
'helpful' again, but perhaps I'm just jaded. :)

-- 
Tom Rini
http://gate.crashing.org/~trini/
