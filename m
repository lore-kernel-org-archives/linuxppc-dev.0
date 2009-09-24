Return-Path: <tj@kernel.org>
Received: from hera.kernel.org (hera.kernel.org [140.211.167.34])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 02CF0B7B69
	for <linuxppc-dev@ozlabs.org>; Thu, 24 Sep 2009 22:59:41 +1000 (EST)
Message-ID: <4ABB6D33.6060706@kernel.org>
Date: Thu, 24 Sep 2009 21:59:31 +0900
From: Tejun Heo <tj@kernel.org>
MIME-Version: 1.0
To: Sachin Sant <sachinp@in.ibm.com>
Subject: Re: 2.6.31-git5 kernel boot hangs on powerpc
References: <4AB0D947.8010301@in.ibm.com> <4AB214C3.4040109@in.ibm.com>
	<1253185994.8375.352.camel@pasglop>	<4AB25B61.9020609@kernel.org>
	<4AB266AF.9080705@in.ibm.com> <4AB49C37.6020003@in.ibm.com>
	<4AB9DAEC.3060309@in.ibm.com> <4AB9DD8F.1040305@kernel.org>
	<4ABA2DE2.6000601@kernel.org> <4ABB269F.6020309@in.ibm.com>
In-Reply-To: <4ABB269F.6020309@in.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: Linux/PPC Development <linuxppc-dev@ozlabs.org>,
	David Miller <davem@davemloft.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Sachin Sant wrote:
> Tejun Heo wrote:
>> Can you please apply the attached patch and see whether anything
>> interesting shows up in the kernel log?
>>   
> Thanks Tejun for the debug patch. Attached here are the relevant logs.
> The only messages related to percpu in the logs are
> 
> <6>PERCPU: Embedded 2 pages/cpu @c000000001200000 s100232 r0 d30840 u524288
> <7>pcpu-alloc: s100232 r0 d30840 u524288 alloc=1*1048576
> <7>pcpu-alloc: [0] 0 1
> The captured logs are with latest git.

Hmm... that means it wasn't caused by rogue percpu pointer access.
Pleast wait a bit.  I'll try to reproduce it.

Thanks.

-- 
tejun
