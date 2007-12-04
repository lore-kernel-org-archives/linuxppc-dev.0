Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id DB2F0DDEDD
	for <linuxppc-dev@ozlabs.org>; Wed,  5 Dec 2007 03:07:36 +1100 (EST)
Message-Id: <E38C9A55-77FC-46DE-AE30-A03A244656EB@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: Jon Loeliger <jdl@jdl.com>, David Gibson <david@gibson.dropbear.id.au>
In-Reply-To: <20071204092611.79e08953@zod.rchland.ibm.com>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v915)
Subject: Re: Merge dtc
Date: Tue, 4 Dec 2007 10:04:53 -0600
References: <20071016050217.GA9052@localhost.localdomain>
	<1196733544.13978.201.camel@pmac.infradead.org>
	<E1IzXmf-0005RJ-27@jdl.com>
	<20071204092611.79e08953@zod.rchland.ibm.com>
Cc: linuxppc-dev <linuxppc-dev@ozlabs.org>, Paul Mackerras <paulus@samba.org>,
	David Woodhouse <dwmw2@infradead.org>, Paul@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Dec 4, 2007, at 9:26 AM, Josh Boyer wrote:

> On Tue, 04 Dec 2007 07:25:57 -0600
> Jon Loeliger <jdl@jdl.com> wrote:
>
>> So, like, the other day David Woodhouse mumbled:
>>>
>>> I think this is a bad idea -- it's hardly a difficult for those  
>>> people
>>> who _do_ need dts to obtain it separately.
>>>
>>> We shouldn't be merging _more_ stuff in.
>>
>> Thanks for chiming in here, David W.  As far as I can tell
>> so far, the only two people who have voiced an opinion on
>> this issue are Dave G, submitting patches, and me disagreeing
>> with the approach.  :-)
>>
>> Anyone else?
>
> I don't see an overwhelmingly great reason to merge it.  It might help
> test people who do automated rebuilds, etc and aren't used to dealing
> with powerpc and it's requirements.  Outside of that, I see it as
> dual-maintenance.
>
> But I'm not doing the maintenance, and it doesn't effect me too much.
> I only ask that a decision is made and executed on soon so we can move
> on.

I'm also in disagreement of duplicating dtc in the kernel.

However, if we are going to do this we should make the path expansion  
for labels work before we do it.

- k
