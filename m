Return-Path: <benh@kernel.crashing.org>
Subject: Re: performance: memcpy vs. __copy_tofrom_user
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Scott Wood <scottwood@freescale.com>
In-Reply-To: <20081013152028.GA18639@ld0162-tx32.am.freescale.net>
References: <48ECC611.3030309@mikroswiat.pl>
	<20081008154212.GA21723@secretlab.ca>
	<18669.28058.495259.72182@cargo.ozlabs.ibm.com>
	<48EDD905.6070609@mikroswiat.pl>
	<18669.58803.48011.686743@cargo.ozlabs.ibm.com>
	<48EE2553.30903@genesi-usa.com> <1223764226.8157.182.camel@pasglop>
	<48F15B7D.3060608@genesi-usa.com>
	<20081013152028.GA18639@ld0162-tx32.am.freescale.net>
Content-Type: text/plain
Date: Tue, 14 Oct 2008 07:50:27 +1100
Message-Id: <1223931027.8157.272.camel@pasglop>
Mime-Version: 1.0
Cc: Dominik Bozek <domino@mikroswiat.pl>, linuxppc-embedded@ozlabs.org,
	Paul Mackerras <paulus@samba.org>, linuxppc-dev@ozlabs.org
Reply-To: benh@kernel.crashing.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


> It doesn't need to be done in non-preemptible sections, if you have a
> separate per-thread save area for kernel fp/altivec use (and appropriate
> flags so an FP unavailable handler knows which regs to restore), and you
> can avoid using it in a preempting context.

Yuck.

Ben.
