Return-Path: <trini@kernel.crashing.org>
Received: from fed1rmmtao10.cox.net (fed1rmmtao10.cox.net [68.230.241.29])
	by ozlabs.org (Postfix) with ESMTP id D8FC267A2F
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 12 Mar 2005 08:00:54 +1100 (EST)
Date: Fri, 11 Mar 2005 14:00:52 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Sylvain Munaut <tnt@246tNt.com>
Message-ID: <20050311210052.GC3098@smtp.west.cox.net>
References: <4231F9F9.5080506@246tNt.com>
	<be4da82f8d12e20b54050e15fd27df36@freescale.com>
	<423203EC.1070003@246tNt.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <423203EC.1070003@246tNt.com>
Cc: LKML <linux-kernel@vger.kernel.org>,
	Embedded PPC Linux list <linuxppc-embedded@ozlabs.org>
Subject: Re: [PATCH 1/2] MPC52xx updates : sparse clean-ups
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Fri, Mar 11, 2005 at 09:47:40PM +0100, Sylvain Munaut wrote:

[snip]
> static struct hw_interrupt_type mpc52xx_ic = {
> -       "MPC52xx",
[snip]
> +       .typename       = "MPC52xx",

Shouldn't that be "  MPC52xx  ", or is that another field I'm thinking
of?

-- 
Tom Rini
http://gate.crashing.org/~trini/
