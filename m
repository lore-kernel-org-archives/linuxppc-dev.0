Return-Path: <galak@kernel.crashing.org>
Received: from nommos.sslcatacombnetworking.com
	(nommos.sslcatacombnetworking.com [67.18.224.114])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 62C03DE047
	for <linuxppc-dev@ozlabs.org>; Thu, 25 Jan 2007 13:08:09 +1100 (EST)
In-Reply-To: <20070124235150.GA26212@localhost.localdomain>
References: <20070124210654.GA10527@ld0162-tx32.am.freescale.net>
	<20070124235150.GA26212@localhost.localdomain>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <56B86A8F-4E40-4C58-A774-0DE3C7AA8CE2@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH 01/18] Include autoconf.h from the bootwrapper.
Date: Wed, 24 Jan 2007 20:08:02 -0600
To: David Gibson <david@gibson.dropbear.id.au>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Jan 24, 2007, at 5:51 PM, David Gibson wrote:

> On Wed, Jan 24, 2007 at 03:06:54PM -0600, Scott Wood wrote:
>> This will be required by the u-boot compatibility code to obtain a
>> compatible bd_t layout, to determine how to calculate the  
>> timebase, and
>> to know what soc fields need to be modified.
>
> Erm.. I believe the omission of *all* kernel header files from the
> boot wrapper code, including the config, is a deliberate decision.
> The idea is that the wrapping can, if necessary, be done independent
> of the kernel build.

I think the problem is how to resolve the variations of the u-boot/ 
ppcboot bd_t that changes from board to board and based on config.

- k
