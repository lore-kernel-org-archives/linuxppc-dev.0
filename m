Return-Path: <dale@farnsworth.org>
Received: from xyzzy.farnsworth.org (unknown [65.200.49.142])
	by ozlabs.org (Postfix) with SMTP id 8D67167A84
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 26 Mar 2005 00:02:47 +1100 (EST)
From: "Dale Farnsworth" <dale@farnsworth.org>
Date: Fri, 25 Mar 2005 06:02:44 -0700
To: Andrey Volkov <avolkov@varma-el.com>,
	linuxppc-embedded@ozlabs.org
Message-ID: <20050325130244.GA3166@xyzzy>
References: <0.20050322_000905.tnt@patchsend.246tNt.com>
	<556f5ce38ca914dce63ca24277af4b3e@freescale.com>
	<423FC578.8040202@246tNt.com> <42427C2F.2070104@varma-el.com>
	<4242CFF8.7090908@246tNt.com> <42430DF0.2050304@varma-el.com>
	<424404E2.2030602@varma-el.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <424404E2.2030602@varma-el.com>
Subject: Re: [RFC] MPC5200 Kernel/UBoot PCI problem
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Fri, Mar 25, 2005 at 12:32:34PM +0000, Andrey Volkov wrote:
> >Board started, after I add udelay(7) in read/write config. Really strange.
> 
> Sylvain, answer was in PCI2.2 specification, not in manual.
> 
> Wolfgang, as I see, you use same trick in u-boot, as Sylvain suggested 
> to me. IMHO this trick is wrong. Below I explain why.
> 
> When I insert udelay(1000) after deassertion of RST# (write 0 to PR of 
> PCIGSCR), AND remove ALL delays from read/write config, board started 
> too ;). Hence problem not in the MPC, but in slow board(s) (re)start
> (I was lucky with my board, because udelay must be 1000000).

Good catch Andrey!

-Dale
