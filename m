Return-Path: <scottwood@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 66CDFDE4D7
	for <linuxppc-dev@ozlabs.org>; Fri, 22 Feb 2008 08:19:49 +1100 (EST)
Message-ID: <47BDEB0A.80706@freescale.com>
Date: Thu, 21 Feb 2008 15:20:10 -0600
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: avorontsov@ru.mvista.com
Subject: Re: [PATCH] [POWERPC] 8xx: timebase frequency should not depend on
	bus-frequency
References: <20080221194508.GA12896@localhost.localdomain>
	<47BDD587.9060206@freescale.com>
	<20080221195918.GA14636@localhost.localdomain>
	<47BDD9E2.5050007@freescale.com>
	<20080221211343.GA24786@localhost.localdomain>
In-Reply-To: <20080221211343.GA24786@localhost.localdomain>
Content-Type: text/plain; charset=UTF-8; format=flowed
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Anton Vorontsov wrote:
> On Thu, Feb 21, 2008 at 02:06:58PM -0600, Scott Wood wrote:
>> Current u-boots don't support device trees at all on 8xx.
> 
> Yes, vanilla u-boots. I assume many of us use some u-boot hacks to
> actually boot with the device tree (no, not cuboots)... ;-)

Fine, but don't expect misbehavior from out-of-tree u-boots to be used 
as justification for the kernel ignoring device tree content. :-)

-Scott
