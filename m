Return-Path: <kenneth@southpole.se>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 4E73DB6EDE
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 11 Aug 2009 06:45:58 +1000 (EST)
Received: from mail.southpole.se (mail.southpole.se [193.12.106.18])
	by ozlabs.org (Postfix) with ESMTP id DF269DDD01
	for <linuxppc-dev@ozlabs.org>; Tue, 11 Aug 2009 06:45:57 +1000 (EST)
Subject: Re: 5121 cache handling.
From: Kenneth Johansson <kenneth@southpole.se>
To: Scott Wood <scottwood@freescale.com>
In-Reply-To: <4A808268.6000107@freescale.com>
References: <1249649632.4940.38.camel@localhost>
	<20090807195600.GB11681@b07421-ec1.am.freescale.net>
	<1249935384.7077.35.camel@localhost> <4A808268.6000107@freescale.com>
Content-Type: text/plain
Date: Mon, 10 Aug 2009 22:45:53 +0200
Message-Id: <1249937153.7077.38.camel@localhost>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2009-08-10 at 15:26 -0500, Scott Wood wrote:
> Kenneth Johansson wrote:
> >>> should not the framebuffer be marked as cache write through. that is the
> >>> W bit should be set in the tlb mapping. Why is this not done ? is that
> >>> feature also not working on 5121 ??
> >> It probably would have been too slow.
> > 
> > how much slower would write through be ? I thought it was not that big
> > of a difference from copy back.
> 
> It's a big difference if you're writing out an entire cache line of data 
> anyway, but because of write-through it goes out one word at a time 
> without bursting.
> 
> -Scott
> 
Yes the memory system would obviously get a higher load but do the CPU
actually see that? do it stall on the write ? 
