Return-Path: <segher@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id DCEDDDDFB1
	for <linuxppc-dev@ozlabs.org>; Mon, 16 Jul 2007 22:55:46 +1000 (EST)
In-Reply-To: <D575BC2B-0554-4290-A6D0-D4FEEE691C11@kernel.crashing.org>
References: <20070709214853.GA29912@ld0162-tx32.am.freescale.net>
	<18066.63111.703924.714899@cargo.ozlabs.ibm.com>
	<A6BAF4A2-B82D-4A69-A4AD-AE797DAE531C@kernel.crashing.org>
	<4694F81A.4010708@freescale.com>
	<D575BC2B-0554-4290-A6D0-D4FEEE691C11@kernel.crashing.org>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <DA5B994D-5423-484C-A79A-45FCD3AEF3D8@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH v2] Allow exec on 32-bit from readable, non-exec pages,
	with a warning.
Date: Mon, 16 Jul 2007 14:55:34 +0200
To: Kumar Gala <galak@kernel.crashing.org>
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

>>>> Actually I see no good reason to enforce no-exec at all if we  
>>>> can't do
>>>> it consistently.  And if we're not going to enforce it then  
>>>> there is
>>>> no point whinging about it.
>>>
>>>
>>> I have a new patch with just this behaviour, Scott is
>>> testing it on old glibc (I think it succeeded, need
>>> confirmation though),
>>
>> It worked fine on glibc 2.2.5 and 2.3.3 (the former of which failed
>> without the patch).
>
> It sounds like this is a candidate for stable 2.6.22.x as well

Yes, it replaces the previous patch and is a bugfix to it.

> once you release the patch.

The only reason I didn't send it out immediately was to not
confuse things further with a broken patch ;-)


Segher
