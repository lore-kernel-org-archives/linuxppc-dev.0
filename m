Return-Path: <suzuki@in.ibm.com>
Received: from e23smtp02.au.ibm.com (e23smtp02.au.ibm.com [202.81.31.144])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e23smtp02.au.ibm.com",
	Issuer "GeoTrust SSL CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 9A7BDB6F7B
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 13 Jul 2011 06:23:10 +1000 (EST)
Received: from d23relay05.au.ibm.com (d23relay05.au.ibm.com [202.81.31.247])
	by e23smtp02.au.ibm.com (8.14.4/8.13.1) with ESMTP id p6CKH4nY010974
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 Jul 2011 06:17:04 +1000
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
	by d23relay05.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	p6CKLXis1495202
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 Jul 2011 06:21:33 +1000
Received: from d23av04.au.ibm.com (loopback [127.0.0.1])
	by d23av04.au.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
	p6CKN9dc030277
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 Jul 2011 06:23:09 +1000
Message-ID: <4E1CAD21.5050803@in.ibm.com>
Date: Wed, 13 Jul 2011 01:52:57 +0530
From: Suzuki Poulose <suzuki@in.ibm.com>
MIME-Version: 1.0
To: Josh Boyer <jwboyer@linux.vnet.ibm.com>
Subject: Re: [PATCH 1/3] powerpc/47x: allow kernel to be loaded in higher
	physical memory
References: <20110705043657.GF13483@ozlabs.org>	<4E12ACD2.9050305@in.ibm.com>
	<CA+5PVA6d9=PfsFbbFKyNSu6a+pUd0=ZBFVXzUYAYmg3hd5poXQ@mail.gmail.com>
In-Reply-To: <CA+5PVA6d9=PfsFbbFKyNSu6a+pUd0=ZBFVXzUYAYmg3hd5poXQ@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: LinuxPPC-dev <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 07/12/11 18:57, Josh Boyer wrote:
> On Tue, Jul 5, 2011 at 2:18 AM, Suzuki Poulose<suzuki@in.ibm.com>  wrote:
>> On 07/05/11 10:06, Tony Breeds wrote:
>>>
>>> From: Dave Kleikamp<shaggy@linux.vnet.ibm.com>
>>>
>>> The 44x code (which is shared by 47x) assumes the available physical
>>> memory
>>> begins at 0x00000000.  This is not necessarily the case in an AMP
>>> environment.
>>>
>>> Support CONFIG_RELOCATABLE for 476 in order to allow the kernel to be
>>> loaded into a higher memory range.
>>
>> I think the code assumes, the kernel is loaded in 256M aligned page. You may
>> want to mention that in the description here.
>
> Suzie, do you have any other concerns with this code in regards to
> your kexec/kdump work for 4xx?  It seems fairly self-contained to me,
> so I'd like to apply it but I want to make sure it is not going to
> majorly conflict with the work you're doing.
Please go ahead.

Thanks
Suzuki
