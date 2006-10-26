Return-Path: <vwool@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [85.21.88.6])
	by ozlabs.org (Postfix) with ESMTP id 4FB406804E
	for <linuxppc-dev@ozlabs.org>; Fri, 27 Oct 2006 06:26:35 +1000 (EST)
Subject: Re: [1/2] build failure for E500 CPUs w/ CONFIG_OPROFLE=y
From: Vitaly Wool <vwool@ru.mvista.com>
To: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <4A3EAE00-3647-4B72-8CDF-ED6E0ADEC910@kernel.crashing.org>
References: <20061026104338.99e89782.vwool@ru.mvista.com>
	<4A3EAE00-3647-4B72-8CDF-ED6E0ADEC910@kernel.crashing.org>
Content-Type: text/plain
Date: Fri, 27 Oct 2006 00:26:29 +0400
Message-Id: <1161894389.2820.14.camel@barja>
Mime-Version: 1.0
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	oprofile-list@lists.sourceforge.net
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hello Kumar,

> This makes sense to me since we are just increasing kernel code size  
> for code we would never use for an FSL_BOOKE part if we do it the  
> other way.  I dont think its that much more messy with the ifdef's.

Okay, if you're fine with this patch, is it possible that you include it
into your tree?

> If you want to do the other cleanup as well I've got no issue with  
> that, but we really should NOT build in support for 7450 into a  
> FSL_BOOKE kernel when reasonably avoidable.

That's fine with me.
As of the cleanups, well... looks to me some more patches will follow
soon, kinda bugfixing ones rather than cleanups first :)

Thanks,
  Vitaly
