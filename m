Return-Path: <mmporter@cox.net>
Received: from fed1rmmtao10.cox.net (fed1rmmtao10.cox.net [68.230.241.29])
	by ozlabs.org (Postfix) with ESMTP id EAC45689FE
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 13 Jan 2006 02:41:32 +1100 (EST)
Date: Thu, 12 Jan 2006 08:31:26 -0700
From: Matt Porter <mporter@kernel.crashing.org>
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Message-ID: <20060112083125.A14293@cox.net>
References: <20051229204040.GA9751@dmt.cnet>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20051229204040.GA9751@dmt.cnet>;
	from marcelo.tosatti@cyclades.com on Thu, Dec 29, 2005 at
	06:40:40PM -0200
Cc: linux-ppc-embedded <linuxppc-embedded@ozlabs.org>
Subject: Re: [PATCH] powerpc: generalize PPC44x_PIN_SIZE
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Thu, Dec 29, 2005 at 06:40:40PM -0200, Marcelo Tosatti wrote:
> 
> Hi, 
> 
> The following patch generalizes PPC44x_PIN_SIZE by changing it to
> PPC_PIN_SIZE, which can be defined by any board to automatically adjust
> VMALLOC_START, avoiding conflicts with pinned virtual space.
> 
> Also define it for 8xx.
> 
> Matt, please review.

ACK, looks good to me.

-Matt
