Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 3E39CDE2EB
	for <linuxppc-dev@ozlabs.org>; Fri,  6 Jun 2008 05:12:49 +1000 (EST)
Message-Id: <E6E776A3-C605-4063-B78D-99B06BAA36EA@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: Josh Boyer <jwboyer@linux.vnet.ibm.com>
In-Reply-To: <20080605101838.5b1d9233@zod.rchland.ibm.com>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v924)
Subject: Re: 4xx support in arch/ppc is going away Real Soon Now
Date: Thu, 5 Jun 2008 13:59:44 -0500
References: <20080605095253.7df9dbe0@zod.rchland.ibm.com>
	<fa686aa40806050811t4ab2fbfk9eed34d0972376c4@mail.gmail.com>
	<20080605101838.5b1d9233@zod.rchland.ibm.com>
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Jun 5, 2008, at 10:18 AM, Josh Boyer wrote:

> On Thu, 5 Jun 2008 09:11:48 -0600
> "Grant Likely" <grant.likely@secretlab.ca> wrote:
>
>> On Thu, Jun 5, 2008 at 8:52 AM, Josh Boyer <jwboyer@linux.vnet.ibm.com 
>> > wrote:
>>> This commit (patch omitted due to size) is sitting in my local tree:
>>>
>>> commit 0d7efc1e80fc262bcc507a605482c5681e3f082a
>>> Author: Josh Boyer <jwboyer@linux.vnet.ibm.com>
>>> Date:   Thu Jun 5 09:46:17 2008 -0500
>>>
>>>   ppc/4xx: Remove 4xx support from arch/ppc
>>>
>>>   Remove support for PPC 403, 405, and 440 processors from arch/ 
>>> ppc.  The
>>>   arch/powerpc equivalents should be used.  Boards that are not  
>>> ported yet
>>>   will need to be ported to arch/powerpc to have continued support.
>>
>> This looks like unneeded churn.
>
> Excellent.  My prompting has succeeded.  Though now I won't get to be
> on top of the "top contributors" list in the lwn.net pages like Kumar
> was.  Oh well.

defconfig updates is the secret :)

- k
