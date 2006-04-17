Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 2F536679EA
	for <linuxppc-dev@ozlabs.org>; Tue, 18 Apr 2006 06:52:03 +1000 (EST)
Subject: Re: PowerBook5,4 -- no sound?
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Andreas Schwab <schwab@suse.de>
In-Reply-To: <je1wvwfh7s.fsf@sykes.suse.de>
References: <878xq51t61.fsf@briny.internal.ondioline.org>
	<je1wvxo70l.fsf@sykes.suse.de>
	<1145220233.9833.11.camel@localhost.localdomain>
	<je7j5phz9j.fsf@sykes.suse.de>
	<1145231658.9833.17.camel@localhost.localdomain>
	<je3bgdhwre.fsf@sykes.suse.de>
	<1145233812.9833.21.camel@localhost.localdomain>
	<je1wvwfh7s.fsf@sykes.suse.de>
Content-Type: text/plain
Date: Tue, 18 Apr 2006 06:51:57 +1000
Message-Id: <1145307118.3912.11.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, Johannes Berg <johannes@sipsolutions.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, 2006-04-17 at 15:45 +0200, Andreas Schwab wrote:
> Benjamin Herrenschmidt <benh@kernel.crashing.org> writes:
> 
> > Interesting... I would have expected that setup to work... Oh well... at
> > this point, the best to do is to add support for your G5 to Johannes new
> > snd-aoa
> 
> I agree.  Unfortunately, the i2sbus probing already fails, due to
> requesting a memory region that is already (partially) claimed by other
> resources:
> 
> request_mem_region(80000000 - 80000fff, i2sbus control)
> 
>       80000000-8007ffff : 0.80000000:mac-io
>         8000002c-8000002f : 0.0000004c:fans
>         80000030-80000033 : 0.0000004c:fans
>         80000034-80000037 : 0.0000004c:fans
>         8000004c-8000004f : 0.0000004c:fans
>         80000050-8000008a : 0.00000050:gpio

Johannes,

Look like the bugs in the device-tree I told you about ...

Ben.
