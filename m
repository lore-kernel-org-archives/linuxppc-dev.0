Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 8DE2ADE59A
	for <linuxppc-dev@ozlabs.org>; Wed,  7 Jan 2009 17:51:52 +1100 (EST)
Subject: Re: [PATCH/RFC] sysfs cache code rewrite
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Nathan Lynch <ntl@pobox.com>
In-Reply-To: <20090106212533.GB7376@localdomain>
References: <20081224045554.GA6958@localdomain>
	<20090106212533.GB7376@localdomain>
Content-Type: text/plain
Date: Wed, 07 Jan 2009 17:51:42 +1100
Message-Id: <1231311102.14860.80.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, 2009-01-06 at 15:25 -0600, Nathan Lynch wrote:
> Please unsubscribe me from... wait, that's not what I meant to say.
> 
> Any thoughts or questions on this one?  I posted this right before the
> holidays so my feelings aren't hurt by the lack of response (yet!)
> 
> To summarize why I think this should go in 2.6.29:
> - Userspace will now be able to determine the true cache topology
>   (the current code doesn't tell you which caches are shared between
>   CPUs).
> - More complete information will be presented on systems that use
>   [di]-cache-block-size properties instead of [di]-cache-line-size. 
> - While overall LOC has increased, the documentation is better, and the
>   functions are much shorter and less complex.

I'm pretty happy about it. However, it fails build when merged on top of
linus current upstream due to some cpumask changes.

I don't know quite the detail of the new cpumask stuff ... It could be
as simple as passing a pointer instead of the value in the
cpumask_scnprintf call though...

Can you check and produce a new patch pls ?

Cheers,
Ben.
