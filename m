Return-Path: <segher@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 544E6DDF17
	for <linuxppc-dev@ozlabs.org>; Sat, 11 Aug 2007 03:44:39 +1000 (EST)
In-Reply-To: <Pine.LNX.4.60.0708092233130.5995@poirot.grange>
References: <Pine.LNX.4.60.0706292113240.4227@poirot.grange>
	<00a85f152aa3547f0f0b4acd7954468a@kernel.crashing.org>
	<Pine.LNX.4.60.0707022114020.3339@poirot.grange>
	<2055bb54b9816faaf5b2ceedc9cfa039@kernel.crashing.org>
	<Pine.LNX.4.60.0707032356270.3876@poirot.grange>
	<E0E696F1-2F9E-4D6B-A194-EB42BA826BCD@kernel.crashing.org>
	<Pine.LNX.4.60.0707180010330.3535@poirot.grange>
	<87DC7695-382B-4641-B9D9-75ACB49D41A4@kernel.crashing.org>
	<Pine.LNX.4.60.0707191932300.3365@poirot.grange>
	<719AE7E4-FE6D-4973-8887-F787EC8ABC85@kernel.crashing.org>
	<Pine.LNX.4.60.0707202219340.3946@poirot.grange>
	<235e0ff22961e25016727c0e74fd0c0f@kernel.crashing.org>
	<Pine.LNX.4.60.0708010739560.4228@poirot.grange>
	<19a13f8700d078abc4cab0064a7d0183@kernel.crashing.org>
	<Pine.LNX.4.60.0708012053240.7394@poirot.grange>
	<46B0F030.9030007@freescale.com>
	<Pine.LNX.4.60.0708080023030.8493@poirot.grange>
	<3368b27f860fafb35d10f6352e9055bf@kernel.crashing.org>
	<Pine.LNX.4.60.0708092233130.5995@poirot.grange>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <ba719699d8cf773af76ec0145fd830af@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH] powerpc: fix i2c device string format
Date: Fri, 10 Aug 2007 19:44:26 +0200
To: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> hm... Well, the worst that could happen, if an "evil" programmer 
> defines
> too long a name, it gets truncated, and then binds to a wrong driver,
> well, the worst that can happen is that your hardware gets damaged, 
> not a
> big thing.

:-)

> However, some might disagree, so, below is a new version...
> Wrap some long lines while at that.
>
> Signed-off-by: G. Liakhovetski <g.liakhovetski@gmx.de>

Looks good to me, thank you!


Segher
