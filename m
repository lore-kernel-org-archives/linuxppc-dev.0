Return-Path: <trini@kernel.crashing.org>
Received: from fed1rmmtao04.cox.net (fed1rmmtao04.cox.net [68.230.241.35])
	by ozlabs.org (Postfix) with ESMTP id B16D567A71
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 24 Feb 2005 05:58:40 +1100 (EST)
Date: Wed, 23 Feb 2005 11:58:38 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Kumar Gala <galak@freescale.com>
Message-ID: <20050223185838.GH345@smtp.west.cox.net>
References: <Pine.LNX.4.61.0502222257230.7799@blarg.somerset.sps.mot.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <Pine.LNX.4.61.0502222257230.7799@blarg.somerset.sps.mot.com>
Cc: akpm@osdl.org, linuxppc-embedded@ozlabs.org
Subject: Re: [PPC32][update] Report chip version in /proc/cpuinfo for 85xx
	boards
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Tue, Feb 22, 2005 at 10:59:17PM -0600, Kumar Gala wrote:
> Andrew,
> 
> Here here is an updated version of the previous patch which fixes a 
> build problem.  It is for post 2.6.11.
> 
> Report the chip version in /proc/cpuinfo on 85xx ADS and CDS platforms.

How about doing it in arch/ppc/kernel/setup.c with a test for it being
non-null (if needed?).

-- 
Tom Rini
http://gate.crashing.org/~trini/
