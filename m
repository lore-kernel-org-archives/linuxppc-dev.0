Return-Path: <dipraksh@linux.vnet.ibm.com>
Received: from e28smtp03.in.ibm.com (e28smtp03.in.ibm.com [122.248.162.3])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e28smtp03.in.ibm.com",
	Issuer "GeoTrust SSL CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 77315B70D4
	for <linuxppc-dev@ozlabs.org>; Fri, 22 Oct 2010 18:40:54 +1100 (EST)
Received: from d28relay03.in.ibm.com (d28relay03.in.ibm.com [9.184.220.60])
	by e28smtp03.in.ibm.com (8.14.4/8.13.1) with ESMTP id o9M7emO0002944
	for <linuxppc-dev@ozlabs.org>; Fri, 22 Oct 2010 13:10:48 +0530
Received: from d28av05.in.ibm.com (d28av05.in.ibm.com [9.184.220.67])
	by d28relay03.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	o9M7empZ4182032
	for <linuxppc-dev@ozlabs.org>; Fri, 22 Oct 2010 13:10:48 +0530
Received: from d28av05.in.ibm.com (loopback [127.0.0.1])
	by d28av05.in.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
	o9M7emXE008608
	for <linuxppc-dev@ozlabs.org>; Fri, 22 Oct 2010 18:40:48 +1100
Message-ID: <4CC13FFF.7040200@linux.vnet.ibm.com>
Date: Fri, 22 Oct 2010 13:10:47 +0530
From: divya <dipraksh@linux.vnet.ibm.com>
MIME-Version: 1.0
To: LKML <linux-kernel@vger.kernel.org>, benh@kernel.crashing.org,
	linuxppc-dev@ozlabs.org
Subject: Re: BUG with the kernel version 2.6.36-rc1 on power machine
References: <4CC13B2C.7090908@linux.vnet.ibm.com>
In-Reply-To: <4CC13B2C.7090908@linux.vnet.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Friday 22 October 2010 12:50 PM, divya wrote:
> Hi ,
>
> With the latest version of kernel 2.6.36-rc1 running on the power 
> machine, came across the following call trace
>
> BUG: looking up invalid subclass: 31
> turning off the locking correctness validator.
> Call Trace:
> [c00000000e0bfb60] [c0000000000119a0] .show_stack+0x6c/0x16c (unreliable)
> [c00000000e0bfc10] [c0000000000c39b8] .lockdep_init_map+0x194/0x630
> [c00000000e0bfcf0] [c0000000005524f8] .mousedev_create+0xcc/0x234
> [c00000000e0bfda0] [c00000000093fb58] .mousedev_init+0x38/0xa0
> [c00000000e0bfe30] [c0000000000097e4] .do_one_initcall+0xd8/0x1c8
> [c00000000e0bfee0] [c0000000009004ac] .kernel_init+0x23c/0x2f8
> [c00000000e0bff90] [c00000000002ad30] .kernel_thread+0x54/0x70
>
> The config file used for make oldconfig is being attached
>
> Thanks
> Divya
>
>
>
>
I meant 2.6.36-git1(b5153163ed580e) , and not 2.6.36-rc1.
Sorry for the confusion.

Thanks
Divya
