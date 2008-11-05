Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from e36.co.us.ibm.com (e36.co.us.ibm.com [32.97.110.154])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e36.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 6A0CCDDE0E
	for <linuxppc-dev@ozlabs.org>; Thu,  6 Nov 2008 08:16:06 +1100 (EST)
Received: from d03relay03.boulder.ibm.com (d03relay03.boulder.ibm.com
	[9.17.195.228])
	by e36.co.us.ibm.com (8.13.1/8.13.1) with ESMTP id mA5LFUEL001341
	for <linuxppc-dev@ozlabs.org>; Wed, 5 Nov 2008 14:15:30 -0700
Received: from d03av04.boulder.ibm.com (d03av04.boulder.ibm.com [9.17.195.170])
	by d03relay03.boulder.ibm.com (8.13.8/8.13.8/NCO v9.1) with ESMTP id
	mA5LFqdl149712
	for <linuxppc-dev@ozlabs.org>; Wed, 5 Nov 2008 14:15:59 -0700
Received: from d03av04.boulder.ibm.com (loopback [127.0.0.1])
	by d03av04.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	mA5LFlNO013017
	for <linuxppc-dev@ozlabs.org>; Wed, 5 Nov 2008 14:15:48 -0700
Date: Wed, 5 Nov 2008 16:15:38 -0500
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: What is the maximum memory linux support for powerpc 4xx?
Message-ID: <20081105161538.4840614d@zod.rchland.ibm.com>
In-Reply-To: <C332CE14-BA70-4527-BF91-ACEF8F6B6612@kernel.crashing.org>
References: <0CA0A16855646F4FA96D25A158E299D60546CA64@SDCEXCHANGE01.ad.amcc.com>
	<0CA0A16855646F4FA96D25A158E299D602C813A9@SDCEXCHANGE01.ad.amcc.com>
	<C332CE14-BA70-4527-BF91-ACEF8F6B6612@kernel.crashing.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org, Victor Gallardo <vgallardo@amcc.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, 5 Nov 2008 10:34:32 -0600
Kumar Gala <galak@kernel.crashing.org> wrote:

> 
> On Nov 5, 2008, at 9:14 AM, Victor Gallardo wrote:
> 
> > Hello,
> >
> > How can I figure out the and/or what is the maximum memory linux  
> > support for powerpc 4xx?
> 
> I'd expect the amount of memory supported to be a bit under 4G at this  
> point.  There is generic work that has been going on to allow ALL  
> ppc32's that have HW support for 36-bit physical to support >4G of  
> memory.. however that code is likely in 2.6.29.

In 4xx-specific terms, it depends on the memory controller as well.
The older SoCs only supported 2GiB in hardware I think.  The Denali
memory controller can do 16GiB in hardware from my recollection.

But you probably already knew that.

josh
