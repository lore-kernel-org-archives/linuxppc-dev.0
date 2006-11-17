Return-Path: <kou.ishizaki@toshiba.co.jp>
Received: from imx12.toshiba.co.jp (imx12.toshiba.co.jp [61.202.160.132])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 0B92167BB2
	for <linuxppc-dev@ozlabs.org>; Fri, 17 Nov 2006 21:07:26 +1100 (EST)
Received: from wall11.toshiba.co.jp (wall11 [133.199.90.149])
	by imx12.toshiba.co.jp  with ESMTP id kAHA7Lmd010208
	for <linuxppc-dev@ozlabs.org>; Fri, 17 Nov 2006 19:07:21 +0900 (JST)
Received: (from root@localhost) by wall11.toshiba.co.jp  id kAHA7L2m000482
	for linuxppc-dev@ozlabs.org; Fri, 17 Nov 2006 19:07:21 +0900 (JST)
Received: from mx2.toshiba.co.jp (localhost [127.0.0.1])
	by ovp11.toshiba.co.jp  with ESMTP id kAHA7KGY013628
	for <linuxppc-dev@ozlabs.org>; Fri, 17 Nov 2006 19:07:20 +0900 (JST)
Date: Fri, 17 Nov 2006 19:07:19 +0900 (JST)
Message-Id: <200611171007.kAHA7KpT006693@toshiba.co.jp>
To: linuxppc-dev@ozlabs.org
Subject: Re: [PATCH 7/16] hypervisor console for Celleb
From: Ishizaki Kou <kou.ishizaki@toshiba.co.jp>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi Arnd-san,

> On Wednesday 15 November 2006 10:41, Ishizaki Kou wrote:
> > This patch adds hypervisor console driver for Celleb platform.
> > 
> Nice small driver. Still, I'd like to know why there is no support
> for interrupts to notify the kernel of incoming characters. This seems
> to have the same (mis-)design as the IBM blade with the rtas console
> that uses no interrupts.

This is caused because the design goal of "console" I/O for Beat is
for debugging Guest OSes that cannot handle interrupts. Adding to that,
the "console" I/O for Beat is deeply inspired by pSeries's one.

Thank you,
Kou Ishizaki
Toshiba
