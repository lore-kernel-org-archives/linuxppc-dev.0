Return-Path: <jimix@watson.ibm.com>
Received: from over.ny.us.ibm.com (over.ny.us.ibm.com [32.97.182.150])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "over.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id CAE5167DE4
	for <linuxppc-dev@ozlabs.org>; Thu, 13 Apr 2006 23:43:27 +1000 (EST)
Received: from e4.ny.us.ibm.com ([192.168.1.104])
	by pokfb.esmtp.ibm.com (8.12.11.20060308/8.12.11) with ESMTP id
	k3DDKL18002314
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <linuxppc-dev@ozlabs.org>; Thu, 13 Apr 2006 09:20:22 -0400
Received: from d01relay02.pok.ibm.com (d01relay02.pok.ibm.com [9.56.227.234])
	by e4.ny.us.ibm.com (8.12.11.20060308/8.12.11) with ESMTP id
	k3DDK26s030160
	for <linuxppc-dev@ozlabs.org>; Thu, 13 Apr 2006 09:20:02 -0400
Received: from d01av01.pok.ibm.com (d01av01.pok.ibm.com [9.56.224.215])
	by d01relay02.pok.ibm.com (8.12.10/NCO/VER6.8) with ESMTP id
	k3DDJqJJ203740
	for <linuxppc-dev@ozlabs.org>; Thu, 13 Apr 2006 09:19:52 -0400
Received: from d01av01.pok.ibm.com (loopback [127.0.0.1])
	by d01av01.pok.ibm.com (8.12.11/8.13.3) with ESMTP id k3DDJqSx018728
	for <linuxppc-dev@ozlabs.org>; Thu, 13 Apr 2006 09:19:52 -0400
In-Reply-To: <1144926434.7777.5.camel@localhost.localdomain>
References: <5148225C-AE27-4365-A1C2-40C46491AF0D@watson.ibm.com>
	<9B2C87C5-0B69-46E7-B48B-9CDB882836B2@watson.ibm.com>
	<20060413053614.2648467DE3@ozlabs.org>
	<C67D530F-2629-4D6B-986B-0FC7CFE525BF@watson.ibm.com>
	<1144926434.7777.5.camel@localhost.localdomain>
Mime-Version: 1.0 (Apple Message framework v749.3)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <2A70CBD7-4A52-4599-8BEF-6AC633F62C83@watson.ibm.com>
From: Jimi Xenidis <jimix@watson.ibm.com>
Subject: Re: [patch][rfc]flattened device tree: Passing a dtb (blob) to Linux.
Date: Thu, 13 Apr 2006 09:19:49 -0400
To: Michael Ellerman <michaelellerman@internode.on.net>
Cc: linuxppc-dev@ozlabs.org, Michael Neuling <mikey@neuling.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Actually, is this even an issue? can the LMB handle repeated  
reservations?
-JX
On Apr 13, 2006, at 7:07 AM, Michael Ellerman wrote:

> On Thu, 2006-04-13 at 06:37 -0400, Jimi Xenidis wrote:
>> On Apr 13, 2006, at 1:36 AM, Michael Neuling wrote:
>>
>>> Hey Jimi,
>>>
>>>>> NOTE: that the dtc must also not generate the blob reservation
>>>>> entry.
>>>>
>>>> This reservation is only generated for "asm" dtc targets so it is
>>>> only that case that need to be changed.
>>>
>>> The user space kexec tools create a reserve map entry for the  
>>> blob as
>>> well.
>> good point, but I thought the kexec tools used dtc, no?
>
> No, but they should.
>
>> looking passed my own world I see:
>>    - iSeries: not reserving the blob at all
>
> That sounds right. I think having the kernel do it is definitely the
> right option.
>
> cheers
>
> -- 
> Michael Ellerman
> IBM OzLabs
>
> wwweb: http://michael.ellerman.id.au
> phone: +61 2 6212 1183 (tie line 70 21183)
>
> We do not inherit the earth from our ancestors,
> we borrow it from our children. - S.M.A.R.T Person
>
