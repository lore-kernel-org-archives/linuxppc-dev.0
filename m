Return-Path: <sshtylyov@ru.mvista.com>
Received: from imap.sh.mvista.com (unknown [63.81.120.155])
	by ozlabs.org (Postfix) with ESMTP id D3FDC68126
	for <linuxppc-dev@ozlabs.org>; Fri, 27 Oct 2006 06:32:25 +1000 (EST)
Message-ID: <45411B46.9060106@ru.mvista.com>
Date: Fri, 27 Oct 2006 00:32:06 +0400
From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
MIME-Version: 1.0
To: Vitaly Wool <vwool@ru.mvista.com>
Subject: Re: [1/2] build failure for E500 CPUs w/ CONFIG_OPROFLE=y
References: <20061026104338.99e89782.vwool@ru.mvista.com>	<4A3EAE00-3647-4B72-8CDF-ED6E0ADEC910@kernel.crashing.org>
	<1161894389.2820.14.camel@barja>
In-Reply-To: <1161894389.2820.14.camel@barja>
Content-Type: text/plain; charset=us-ascii; format=flowed
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

Hello.

Vitaly Wool wrote:
> Hello Kumar,

>>This makes sense to me since we are just increasing kernel code size  
>>for code we would never use for an FSL_BOOKE part if we do it the  
>>other way.  I dont think its that much more messy with the ifdef's.

> Okay, if you're fine with this patch, is it possible that you include it
> into your tree?

>>If you want to do the other cleanup as well I've got no issue with  
>>that, but we really should NOT build in support for 7450 into a  
>>FSL_BOOKE kernel when reasonably avoidable.

> That's fine with me.
> As of the cleanups, well... looks to me some more patches will follow
> soon, kinda bugfixing ones rather than cleanups first :)

   The most funny/stupd thing is that the patch existed since May but it never 
went in:

http://patchwork.ozlabs.org/linuxppc/patch?id=5531

> Thanks,
>   Vitaly

WBR, Sergei
