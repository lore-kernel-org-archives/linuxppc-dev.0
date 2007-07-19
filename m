Return-Path: <segher@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 54B4ADDDF4
	for <linuxppc-dev@ozlabs.org>; Fri, 20 Jul 2007 03:12:00 +1000 (EST)
In-Reply-To: <20070719205745.57f9d5a0@localhost.localdomain>
References: <20070718013604.GU15238@ld0162-tx32.am.freescale.net>
	<F8A0BE8F-8DBE-42DC-B3CD-02EB339A739E@kernel.crashing.org>
	<20070719205745.57f9d5a0@localhost.localdomain>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <B71D432E-5C61-4873-9B35-9C7825AABCBD@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH 49/61] 8xx: Update device trees.
Date: Thu, 19 Jul 2007 19:11:40 +0200
To: Vitaly Bordug <vitb@kernel.crashing.org>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

>>> +				fsl,cpm-brg = <1>;
>>> +				fsl,cpm-command = <0090>;
>>
>> Are these two documented?  Your patch queue is too
>> long for me to check for myself.
>>
> In fact, there were different approaches to describe CPM, and I am  
> sure this is not the end.
> These aren't documented, and I think we do not need that so far: I  
> am pretty sure this will change
> to something more comfortable as new similar ports will follow-up.  
> Meanwhile, values are self-description
> for anybody familiar with this SoC.

Even when it is a work in progress still, it would be a good
idea to start documenting the device binding.

>>> -	soc885@ff000000 {
>>> +	bcsr@ff080000 {
>>
>> Maybe use a more generic name, I have no idea what a
>> "BCSR" is.
>>
> IIRC, QE stuff, when first introduced, had bcsr bindings, that were  
> discussed and agreed here.

Sure, that's not the point.

Since you are using generic names, the only use for the "name"
of a node is for a human reader to understand your tree.  Maybe
everyone using this specific SoC knows what a BCSR is; or maybe
there is a more friendly name you could use.


Segher
