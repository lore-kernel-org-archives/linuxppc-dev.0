Return-Path: <mmporter@cox.net>
Received: from fed1rmmtao01.cox.net (fed1rmmtao01.cox.net [68.230.241.38])
	by ozlabs.org (Postfix) with ESMTP id D578467A65
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 16 Mar 2005 07:50:30 +1100 (EST)
Date: Tue, 15 Mar 2005 13:50:22 -0700
From: Matt Porter <mporter@kernel.crashing.org>
To: "McMullan, Jason" <jason.mcmullan@timesys.com>
Message-ID: <20050315135022.D5861@cox.net>
References: <1110907039.24673.12.camel@rhino.az.mvista.com>
	<1110915063.5937.93.camel@ad.doubleclick.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1110915063.5937.93.camel@ad.doubleclick.net>;
	from jason.mcmullan@timesys.com on Tue, Mar 15, 2005 at
	02:27:57PM -0500
Cc: linuxppc-embedded <linuxppc-embedded@ozlabs.org>
Subject: Re: 440EP FPU patch
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Tue, Mar 15, 2005 at 02:27:57PM -0500, McMullan, Jason wrote:
> This patch (against vanilla 2.4.11.3) breaks out the FPU code for
> PowerPC into a common .S code for all the head*.S files.
> 
> Less cargo-culted code.
> 
> Wade, you may want to integrate this into your 440EP patch.

Hi Jason,

Can you change CONFIG_FPU->CONFIG_PPC_FPU? Otherwise, this looks
like exactly what we need to me.

-Matt
