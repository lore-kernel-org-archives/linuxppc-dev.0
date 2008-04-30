Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 4BFD3DDEF9
	for <linuxppc-dev@ozlabs.org>; Thu,  1 May 2008 07:19:07 +1000 (EST)
Subject: Re: [RFC] [PATCH] vmemmap fixes to use smaller pages
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Geoff Levand <geoffrey.levand@am.sony.com>
In-Reply-To: <4818C33F.60007@am.sony.com>
References: <1209534108.18023.221.camel@pasglop> <4818C33F.60007@am.sony.com>
Content-Type: text/plain
Date: Thu, 01 May 2008 07:18:58 +1000
Message-Id: <1209590338.18023.230.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>
Reply-To: benh@kernel.crashing.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Wed, 2008-04-30 at 12:06 -0700, Geoff Levand wrote:
> > booting 2.6.25 with a ps3_defconfig and that doesn't work neither
> > (though at least when doing the later, I do get a black screen & no
> > sync, like of ps3fb failed monitor detection, while with current
> > upstream, I just get the last kexec messages and nothing happens).
> 
> 
> This should work.  You are the first to report a problem with 
> 2.6.25.  Could you double check your build, and if you still have
> trouble, put your vmlinux somewhere I can get it?

I'll dbl check today. It could be bad monitor detection...

> OK, I'll try it with the upstream kernel from last week and report
> within the next day or so.

Thanks.

Cheers,
Ben.
