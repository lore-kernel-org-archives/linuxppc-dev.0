Return-Path: <balbir@linux.vnet.ibm.com>
Received: from e35.co.us.ibm.com (e35.co.us.ibm.com [32.97.110.153])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e35.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 927CEDDDEB
	for <linuxppc-dev@ozlabs.org>; Mon, 10 Dec 2007 00:20:36 +1100 (EST)
Received: from d03relay02.boulder.ibm.com (d03relay02.boulder.ibm.com
	[9.17.195.227])
	by e35.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id lB9DKVFU031384
	for <linuxppc-dev@ozlabs.org>; Sun, 9 Dec 2007 08:20:31 -0500
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
	by d03relay02.boulder.ibm.com (8.13.8/8.13.8/NCO v8.7) with ESMTP id
	lB9DKVWP161722
	for <linuxppc-dev@ozlabs.org>; Sun, 9 Dec 2007 06:20:31 -0700
Received: from d03av02.boulder.ibm.com (loopback [127.0.0.1])
	by d03av02.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	lB9DKVkr015784
	for <linuxppc-dev@ozlabs.org>; Sun, 9 Dec 2007 06:20:31 -0700
Message-ID: <475BEB9E.4070606@linux.vnet.ibm.com>
Date: Sun, 09 Dec 2007 18:50:30 +0530
From: Balbir Singh <balbir@linux.vnet.ibm.com>
MIME-Version: 1.0
To: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH] Fake NUMA emulation for PowerPC
References: <20071207211425.10223.91240.sendpatchset@balbir-laptop>
	<20071207212817.GA391@lixom.net>
	<4759BCA2.1020809@linux.vnet.ibm.com>
	<975B5B2B-C1F3-4021-9AE2-8873FFE1BDEC@kernel.crashing.org>
	<4759C548.6030304@linux.vnet.ibm.com>
	<alpine.DEB.0.9999.0712071508460.27689@chino.kir.corp.google.com>
	<475A1BEE.2050109@linux.vnet.ibm.com>
	<20071209131636.GF4381@ucw.cz>
In-Reply-To: <20071209131636.GF4381@ucw.cz>
Content-Type: text/plain; charset=ISO-8859-1
Cc: Olof Johansson <olof@lixom.net>, linuxppc-dev@ozlabs.org,
	LKML <linux-kernel@vger.kernel.org>, David Rientjes <rientjes@google.com>
Reply-To: balbir@linux.vnet.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Pavel Machek wrote:
> On Sat 2007-12-08 09:52:06, Balbir Singh wrote:
>> David Rientjes wrote:
>>> On Sat, 8 Dec 2007, Balbir Singh wrote:
>>>
>>>> To be able to test the memory controller under NUMA, I use fake NUMA
>>>> nodes. x86-64 has a similar feature, the code I have here is the
>>>> simplest I could come up with for PowerPC.
>>>>
>>> Magnus Damm had patches from over a year ago that, I believe, made much of 
>>> the x86_64 fake NUMA code generic so that it could be extended for 
>>> architectures such as i386.  Perhaps he could resurrect those patches if 
>>> there is wider interest in such a tool.
>> That would be a very interesting patch, but what I have here is the
>> simplest patch and we could build on it incrementally. The interface is
>> non-standard but it does amazing things for 59 lines of code change.
> 
> Well, maybe it is amazing, but having non-standard interface is also
> wrong...
> 

I tend to agree with you, but in this case it's mostly debug
infrastructure that is architecture specific.

-- 
	Warm Regards,
	Balbir Singh
	Linux Technology Center
	IBM, ISTL
