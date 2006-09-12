Return-Path: <vbordug@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [85.21.88.6])
	by ozlabs.org (Postfix) with ESMTP id BFF6267B22
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 13 Sep 2006 02:20:34 +1000 (EST)
Date: Tue, 12 Sep 2006 20:20:49 +0400
From: Vitaly Bordug <vbordug@ru.mvista.com>
To: Fredrik Roubert <roubert@df.lth.se>
Subject: Re: How to move from /ppc/ to /powerpc/
Message-ID: <20060912202049.36bf1428@vitb.ru.mvista.com>
In-Reply-To: <20060912153316.GC16340@igloo.df.lth.se>
References: <20060912153316.GC16340@igloo.df.lth.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Tue, 12 Sep 2006 17:33:16 +0200
Fredrik Roubert <roubert@df.lth.se> wrote:

> Hi!
> 
> I have a custom board on which I currently run Linux 2.6.18-rc6
> configured for MPC834x_SYS in the /ppc/ tree, which just a few minor
> changes. Now I'm interested to move to using the /powerpc/ source tree
> instead, but I can't figure out exactly what steps are necessary to do
> this.
> 
> Does anyone run a MPC834x_SYS built with ARCH=powerpc?
> 
Actually it was the first ppc board actually moved over to powerpc.

> I boot the board with U-Boot (version 1.1.4, customized), and I assume
> that I need to add some stuff for this new device tree thing, but I
> can't figure out exactly what the kernel will expect.
You'll need to replace u-boot with custom one that is able to deal with dts. There are 2 ways ATM - use bootm dts approach, which could load device tree from external source, and built-in that makes in compiled into u-boot.

Both patches against u-boot should be searched in u-boot mailing list archives. For 83xx both way work just fine.


-- 
Sincerely, 
Vitaly
