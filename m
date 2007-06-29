Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 41EBCDDFA7
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 29 Jun 2007 13:15:46 +1000 (EST)
In-Reply-To: <20070628083624.GE8794@dd.nec.com.au>
References: <F795765B112E7344AF36AA911279641502D1A42C@xmb-sjc-212.amer.cisco.com>
	<2DD9CF30-5127-4EC1-8D8E-BC6552A832AE@kernel.crashing.org>
	<20070628074430.GC8794@dd.nec.com.au>
	<20070628083624.GE8794@dd.nec.com.au>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <780999D9-1628-4708-9ED4-61C51A200A49@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: ARCH=ppc or ARCH=powerpc
Date: Thu, 28 Jun 2007 22:15:38 -0500
To: Erik Christiansen <erik@dd.nec.com.au>
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


On Jun 28, 2007, at 3:36 AM, Erik Christiansen wrote:

> On Thu, Jun 28, 2007 at 05:44:30PM +1000, Erik Christiansen wrote:
>> Encountering a kernel build error with ARCH=ppc, after configuring  
>> as much as
>> possible for MPC8248, I've just tried ARCH=powerpc on  
>> linux-2.6.21.5, with this
>> slightly scary result:
>
> Oh dear. Please excuse the noise. That was clearly acute lack of
> familiarity with menuconfig.   <blush>
>
> Minus fingerfumbling, ARCH=powerpc starts to build, before coughing  
> up a
> bunch of compiler errors:
>
> cpm2_common.c:63: error: 'CPM_MAP_ADDR' undeclared
>
> Is that due to this patch not being accepted?:
>    http://patchwork.ozlabs.org/linuxppc/patch?id=8891
>
> If the patch's "State Superseded" means something else fixes the build
> failure, then how could I lay my grubby paws on that little gem?

It probably means there was a newer version of the patch w/changes  
made to it based on feedback.

- k
