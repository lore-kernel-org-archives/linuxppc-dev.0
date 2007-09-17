Return-Path: <sven@powerlinux.fr>
Received: from archon.plz.fr (archon.plz.fr [194.50.78.210])
	by ozlabs.org (Postfix) with ESMTP id 159FEDDDF6
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 17 Sep 2007 20:21:15 +1000 (EST)
Date: Mon, 17 Sep 2007 11:53:34 +0200
To: Domen Puncer <domen@coderock.org>
Subject: Re: [RFC PATCH v0.2] net driver: mpc52xx fec
Message-ID: <20070917095334.GA4546@powerlinux.fr>
References: <20070810095153.GC13994@moe.telargo.com>
	<20070902074143.GB2642@nd47.coderock.org>
	<fa686aa40709030857j6c36c87ek60215f812864ee0f@mail.gmail.com>
	<20070915121444.GA19857@nd47.coderock.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20070915121444.GA19857@nd47.coderock.org>
From: Sven Luther <sven@powerlinux.fr>
Cc: netdev@vger.kernel.org, linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Sat, Sep 15, 2007 at 02:14:44PM +0200, Domen Puncer wrote:
> Updated and split version at:
> http://coderock.org/tmp/fec-v3rc1/
> 
> I'll repost to lists once I run-test them.

When applying those patches, the build did die with :


  ERROR: "phy_mii_ioctl" [drivers/net/fec_mpc52xx/fec_mpc52xx.ko] undefined!

Apparently, phy_mii_ioctl is not an exported symbol.

Domen, did you maybe forget a little snipplet when you cut the patches
in different pieces ? Or did i mess up applying them ?

Friendly,

Sven Luther
