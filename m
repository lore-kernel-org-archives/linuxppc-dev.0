Return-Path: <tim@physik3.uni-rostock.de>
Received: from gans.physik3.uni-rostock.de (unknown [139.30.44.2])
	by ozlabs.org (Postfix) with ESMTP id 3616BDDE09
	for <linuxppc-dev@ozlabs.org>; Sat,  6 Jan 2007 06:05:20 +1100 (EST)
Received: from gockel.physik3.uni-rostock.de (gockel.physik3.uni-rostock.de
	[139.30.44.16])
	by gans.physik3.uni-rostock.de (Postfix) with ESMTP id AF6173688F
	for <linuxppc-dev@ozlabs.org>; Fri,  5 Jan 2007 19:45:29 +0100 (CET)
Date: Fri, 5 Jan 2007 19:45:25 +0100 (CET)
From: Tim Schmielau <tim@physik3.uni-rostock.de>
To: Mariusz Kozlowski <m.kozlowski@tuxland.pl>
Subject: Re: 2.6.20-rc3-mm1
In-Reply-To: <200701051723.08112.m.kozlowski@tuxland.pl>
Message-ID: <Pine.LNX.4.63.0701051944490.21110@gockel.physik3.uni-rostock.de>
References: <20070104220200.ae4e9a46.akpm@osdl.org>
	<200701051723.08112.m.kozlowski@tuxland.pl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Andrew Morton <akpm@osdl.org>, linuxppc-dev@ozlabs.org,
	linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, 5 Jan 2007, Mariusz Kozlowski wrote:

> 	Doesn't build on my iMac G3 based garage jukebox ;-)
> 
> arch/powerpc/kernel/of_platform.c:479: error: unknown field 'multithread_probe' specified in initializer
> arch/powerpc/kernel/of_platform.c:479: warning: initialization makes pointer from integer without a cast
> make[1]: *** [arch/powerpc/kernel/of_platform.o] Blad 1
> make: *** [arch/powerpc/kernel] Blad 2

Can you please post your .config?

Thanks,
Tim
