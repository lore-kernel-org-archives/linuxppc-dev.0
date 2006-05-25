Return-Path: <segher@kernel.crashing.org>
Received: from mail-in-09.arcor-online.net (mail-in-09.arcor-online.net
	[151.189.21.49])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.arcor.de",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 872DC67A70
	for <linuxppc-dev@ozlabs.org>; Fri, 26 May 2006 09:07:33 +1000 (EST)
In-Reply-To: <1148593014.15517.32.camel@basalt.austin.ibm.com>
References: <1147988040.2692.40.camel@basalt.austin.ibm.com>
	<17516.64514.854281.64425@cargo.ozlabs.ibm.com>
	<1148593014.15517.32.camel@basalt.austin.ibm.com>
Mime-Version: 1.0 (Apple Message framework v750)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <0EC3795C-A385-4ACE-9C2C-9F413DAF04AD@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [patch] fix RTC/NVRAM accesses on Maple
Date: Fri, 26 May 2006 01:07:35 +0200
To: Hollis Blanchard <hollisb@us.ibm.com>
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

>> Care to redo the patch?
>
> After some offline discussion, I think we're in agreement that these
> properties are fine, since Linux's device tree code can't handle
> multiple ranges. Right Segher?

Not fine, but good enough for now, will need more work elsewhere
before we can do "the right thing" here.

> Hollis Blanchard
> IBM Linux Technology Center
>
> Due to a firmware device tree bug, RTC and NVRAM accesses (including
> halt/reboot) on Maple have been broken since January, when an untested
> build fix went in. This code patches the device tree in Linux.
>
> Signed-off-by: Hollis Blanchard <hollisb@us.ibm.com>
Signed-off-by: Segher Boessenkool <segher@kernel.crashing.org>
