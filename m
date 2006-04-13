Return-Path: <jimix@watson.ibm.com>
Received: from e32.co.us.ibm.com (e32.co.us.ibm.com [32.97.110.150])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e32.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 05C8067DBA
	for <linuxppc-dev@ozlabs.org>; Thu, 13 Apr 2006 20:37:56 +1000 (EST)
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com
	[9.17.195.106])
	by e32.co.us.ibm.com (8.12.11.20060308/8.12.11) with ESMTP id
	k3DAbrId012420
	for <linuxppc-dev@ozlabs.org>; Thu, 13 Apr 2006 06:37:53 -0400
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
	by d03relay04.boulder.ibm.com (8.12.10/NCO/VER6.8) with ESMTP id
	k3DAfBAh167782
	for <linuxppc-dev@ozlabs.org>; Thu, 13 Apr 2006 04:41:11 -0600
Received: from d03av02.boulder.ibm.com (loopback [127.0.0.1])
	by d03av02.boulder.ibm.com (8.12.11/8.13.3) with ESMTP id
	k3DAbq9t025964
	for <linuxppc-dev@ozlabs.org>; Thu, 13 Apr 2006 04:37:52 -0600
In-Reply-To: <20060413053614.2648467DE3@ozlabs.org>
References: <5148225C-AE27-4365-A1C2-40C46491AF0D@watson.ibm.com>
	<9B2C87C5-0B69-46E7-B48B-9CDB882836B2@watson.ibm.com>
	<20060413053614.2648467DE3@ozlabs.org>
Mime-Version: 1.0 (Apple Message framework v749.3)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <C67D530F-2629-4D6B-986B-0FC7CFE525BF@watson.ibm.com>
From: Jimi Xenidis <jimix@watson.ibm.com>
Subject: Re: [patch][rfc]flattened device tree: Passing a dtb (blob) to Linux.
Date: Thu, 13 Apr 2006 06:37:50 -0400
To: Michael Neuling <mikey@neuling.org>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Apr 13, 2006, at 1:36 AM, Michael Neuling wrote:

> Hey Jimi,
>
>>> NOTE: that the dtc must also not generate the blob reservation
>>> entry.
>>
>> This reservation is only generated for "asm" dtc targets so it is
>> only that case that need to be changed.
>
> The user space kexec tools create a reserve map entry for the blob as
> well.
good point, but I thought the kexec tools used dtc, no?
looking passed my own world I see:
   - bootx: creates a reservation entry
   - iSeries: not reserving the blob at all
-JX
