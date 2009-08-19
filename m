Return-Path: <galak@kernel.crashing.org>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 03FF3B70B0
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 19 Aug 2009 23:43:08 +1000 (EST)
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 6447EDDD0B
	for <linuxppc-dev@ozlabs.org>; Wed, 19 Aug 2009 23:43:06 +1000 (EST)
Message-Id: <2E8B90A3-A3FD-4EC8-9D41-1BA9E8B261AB@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
In-Reply-To: <1250667232.4810.20.camel@pasglop>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v936)
Subject: Re: powerpc-next rebased
Date: Wed, 19 Aug 2009 08:43:00 -0500
References: <1250667232.4810.20.camel@pasglop>
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Aug 19, 2009, at 2:33 AM, Benjamin Herrenschmidt wrote:

> Allright it's done, let's hope I didn't screw up :-)

You screwed it up... :)

The commits you pulled in from me you seem to have changed the author  
of the commits which is NOT cool at all.  Adding signed-off-by is  
good, changing the committer is ok, but changing the author of the  
commit is not.  Please fix this ASAP.

Here's an example (in your tree):

http://git.kernel.org/?p=linux/kernel/git/benh/powerpc.git;a=commitdiff;h=87f1e94c949c28fdaa079d5115a8010c9a40569d

vs the commit in my tree:

http://git.kernel.org/?p=linux/kernel/git/galak/powerpc.git;a=commit;h=d920991f7e02788ba2b468b3023e5bbbc7a32f30

- k
