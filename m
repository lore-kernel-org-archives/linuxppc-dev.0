Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 80002DDD0B
	for <linuxppc-dev@ozlabs.org>; Thu,  6 Nov 2008 03:34:57 +1100 (EST)
Message-Id: <C332CE14-BA70-4527-BF91-ACEF8F6B6612@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: "Victor Gallardo" <vgallardo@amcc.com>
In-Reply-To: <0CA0A16855646F4FA96D25A158E299D602C813A9@SDCEXCHANGE01.ad.amcc.com>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v929.2)
Subject: Re: What is the maximum memory linux support for powerpc 4xx?
Date: Wed, 5 Nov 2008 10:34:32 -0600
References: <0CA0A16855646F4FA96D25A158E299D60546CA64@SDCEXCHANGE01.ad.amcc.com>
	<0CA0A16855646F4FA96D25A158E299D602C813A9@SDCEXCHANGE01.ad.amcc.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Nov 5, 2008, at 9:14 AM, Victor Gallardo wrote:

> Hello,
>
> How can I figure out the and/or what is the maximum memory linux  
> support for powerpc 4xx?

I'd expect the amount of memory supported to be a bit under 4G at this  
point.  There is generic work that has been going on to allow ALL  
ppc32's that have HW support for 36-bit physical to support >4G of  
memory.. however that code is likely in 2.6.29.

- k
