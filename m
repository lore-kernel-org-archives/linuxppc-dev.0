Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 7B8E5DDF10
	for <linuxppc-dev@ozlabs.org>; Wed, 19 Dec 2007 03:42:49 +1100 (EST)
Message-Id: <67EFE423-4DA4-486B-A51A-CB73FD5297D2@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: Dale Farnsworth <dale@farnsworth.org>
In-Reply-To: <20071218162032.GB28931@xyzzy.farnsworth.org>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v915)
Subject: Re: [PATCH 07/10] powerpc: Implement kmap_atomic_pfn on powerpc
Date: Tue, 18 Dec 2007 10:42:36 -0600
References: <20071122154638.GA26514@xyzzy.farnsworth.org>
	<1197699461.6696.45.camel@pasglop>
	<20071218162032.GB28931@xyzzy.farnsworth.org>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Dec 18, 2007, at 10:20 AM, Dale Farnsworth wrote:

> On Sat, Dec 15, 2007 at 05:17:41PM +1100, Benjamin Herrenschmidt  
> wrote:
>>
>> On Thu, 2007-11-22 at 08:46 -0700, Dale Farnsworth wrote:
>>> This is needed for the ppc32 /dev/oldmem driver of crash dump.
>>
>> Kumar's working (well, last I heard he was) on a fixmap mechanism
>> so we can do that sort of thing without CONFIG_HIGHMEM, you may
>> want to sync with him here, that would allow to shrink the crash
>> kernel by not having highmem selected.
>>
>> Cheers,
>> Ben.
>
> Kumar, are you close to posting something that would make the
> patch below unnecessary (or change it significantly)?  If so,
> I'll hold off.

My plan is to get the fixmap stuff posted this week.

- k
