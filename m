Return-Path: <balbir@linux.vnet.ibm.com>
Received: from e34.co.us.ibm.com (e34.co.us.ibm.com [32.97.110.152])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e34.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id C55B5DDE1C
	for <linuxppc-dev@ozlabs.org>; Sat,  8 Dec 2007 08:43:42 +1100 (EST)
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com
	[9.17.195.106])
	by e34.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id lB7Lhc0p007345
	for <linuxppc-dev@ozlabs.org>; Fri, 7 Dec 2007 16:43:39 -0500
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
	by d03relay04.boulder.ibm.com (8.13.8/8.13.8/NCO v8.7) with ESMTP id
	lB7Lhcul125614
	for <linuxppc-dev@ozlabs.org>; Fri, 7 Dec 2007 14:43:38 -0700
Received: from d03av02.boulder.ibm.com (loopback [127.0.0.1])
	by d03av02.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	lB7Lhcq4008880
	for <linuxppc-dev@ozlabs.org>; Fri, 7 Dec 2007 14:43:38 -0700
Message-ID: <4759BE88.3020702@linux.vnet.ibm.com>
Date: Sat, 08 Dec 2007 03:13:36 +0530
From: Balbir Singh <balbir@linux.vnet.ibm.com>
MIME-Version: 1.0
To: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
Subject: Re: [PATCH] Fake NUMA emulation for PowerPC
References: <20071207211425.10223.91240.sendpatchset@balbir-laptop>
	<Pine.LNX.4.62.0712072229280.26862@pademelon.sonytel.be>
	<4759BCBA.7060800@linux.vnet.ibm.com>
In-Reply-To: <4759BCBA.7060800@linux.vnet.ibm.com>
Content-Type: text/plain; charset=UTF-8
Cc: linuxppc-dev@ozlabs.org, LKML <linux-kernel@vger.kernel.org>
Reply-To: balbir@linux.vnet.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Balbir Singh wrote:
> Geert Uytterhoeven wrote:
>> On Sat, 8 Dec 2007, Balbir Singh wrote:
>>> +	if (strstr(p, "fake="))
>>> +		cmdline = p + 5;	/* 5 is faster than strlen("fake=") */
>> Really? My gcc is smart enough to replace the `strlen("fake=")' by 5, even
>> without -O.
>>
> 
> Thanks for pointing that out, but I am surprised that a compiler would
> interpret library routines like strlen.
> 

I just tested it and it turns out that you are right. I'll go hunt to
see where gcc gets its magic powers from.

>> With kind regards,
>>
>> Geert Uytterhoeven
>> Software Architect
> 
> 
