Return-Path: <SRS0+c25b18fbc1076e96b82a+1749+infradead.org+dwmw2@bombadil.srs.infradead.org>
Received: from bombadil.infradead.org (bombadil.infradead.org [18.85.46.34])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 518F5DDE18
	for <linuxppc-dev@ozlabs.org>; Sat,  7 Jun 2008 19:46:33 +1000 (EST)
Subject: Re: [rtc-linux] Re: state of GEN_RTC vs rtc subsystem
From: David Woodhouse <dwmw2@infradead.org>
To: rtc-linux@googlegroups.com
In-Reply-To: <484473E6.5060400@am.sony.com>
References: <47B18612-66A3-476C-B81C-F2FD11CE9A64@kernel.crashing.org>
	<20080220180325.46446675@i1501.lan.towertech.it>
	<48408394.8000406@am.sony.com>  <484473E6.5060400@am.sony.com>
Content-Type: text/plain
Date: Sat, 07 Jun 2008 10:46:26 +0100
Message-Id: <1212831986.32207.416.camel@pmac.infradead.org>
Mime-Version: 1.0
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	Alessandro Zummo <alessandro.zummo@towertech.it>,
	rz@linux-m68k.org, LKML Kernel <linux-kernel@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, 2008-06-02 at 15:27 -0700, Geoff Levand wrote:
> 
> Just to follow up, I found that David Woodhouse has submitted
> a patch which does this:
> 
>    http://patchwork.ozlabs.org/linuxppc/patch?id=18139

It's merged now:
http://git.kernel.org/?p=linux/kernel/git/torvalds/linux-2.6.git;a=commitdiff;h=aabe1885

-- 
dwmw2
