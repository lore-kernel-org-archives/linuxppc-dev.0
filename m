Return-Path: <scottwood@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 838DCDDF49
	for <linuxppc-embedded@ozlabs.org>;
	Thu,  6 Dec 2007 04:50:33 +1100 (EST)
Message-ID: <4756E4F0.8050906@freescale.com>
Date: Wed, 05 Dec 2007 11:50:40 -0600
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: michael.firth@bt.com
Subject: Re: Maximum ioremap size for ppc arch?
References: <36D7B34A3A79F84F82FA0C154F299F2506080F6F@E03MVX1-UKDY.domain1.systemhost.net>
	<4756E3E8.8090102@freescale.com>
In-Reply-To: <4756E3E8.8090102@freescale.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Scott Wood wrote:
> michael.firth@bt.com wrote:
>> This seems to leave only 1GB of addressing space for all the
>> physically addressable memory (RAM + ioremapped + registers), while
>> reserving 3GB of space for user processes. The 3GB is presumably
>> mostly unusable on a system without a large amount of swap, as the
>> 1GB limit on memory will prevent much more than that being available
>> for user space.
> 
> Well, it's also useful for sparse mappings, but I agree that the 3/1 
> split is probably suboptimal for most workloads.

Oh, and the 3G user is also useful for accessing highmem, of course.

-Scott
