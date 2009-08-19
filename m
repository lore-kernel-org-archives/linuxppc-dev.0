Return-Path: <galak@kernel.crashing.org>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id EEC90B6F2B
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 19 Aug 2009 23:54:30 +1000 (EST)
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 4EEC1DDD04
	for <linuxppc-dev@ozlabs.org>; Wed, 19 Aug 2009 23:54:29 +1000 (EST)
Message-Id: <5CBF10F7-8927-47AD-B4F8-1F07754207A8@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <2E8B90A3-A3FD-4EC8-9D41-1BA9E8B261AB@kernel.crashing.org>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v936)
Subject: Re: powerpc-next rebased
Date: Wed, 19 Aug 2009 08:54:18 -0500
References: <1250667232.4810.20.camel@pasglop>
	<2E8B90A3-A3FD-4EC8-9D41-1BA9E8B261AB@kernel.crashing.org>
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Aug 19, 2009, at 8:43 AM, Kumar Gala wrote:

>
> On Aug 19, 2009, at 2:33 AM, Benjamin Herrenschmidt wrote:
>
>> Allright it's done, let's hope I didn't screw up :-)
>
> You screwed it up... :)
>
> The commits you pulled in from me you seem to have changed the  
> author of the commits which is NOT cool at all.  Adding signed-off- 
> by is good, changing the committer is ok, but changing the author of  
> the commit is not.  Please fix this ASAP.
>
> Here's an example (in your tree):
>
> http://git.kernel.org/?p=linux/kernel/git/benh/powerpc.git;a=commitdiff;h=87f1e94c949c28fdaa079d5115a8010c9a40569d
>
> vs the commit in my tree:
>
> http://git.kernel.org/?p=linux/kernel/git/galak/powerpc.git;a=commit;h=d920991f7e02788ba2b468b3023e5bbbc7a32f30

I'll leave my tree alone to allow you to try and fix this.  It looks  
like the stuff you pulled in from Josh's tree also has similar foobar.

- k
