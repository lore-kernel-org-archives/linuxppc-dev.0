Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id DF4CCDDECF
	for <linuxppc-dev@ozlabs.org>; Thu,  4 Oct 2007 00:43:27 +1000 (EST)
In-Reply-To: <4703A9B4.6010507@freescale.com>
References: <11903212461510-git-send-email-timur@freescale.com>
	<20071003133032.GA2417@localhost.localdomain>
	<4703A453.8080305@freescale.com>
	<20071003143417.GA5123@localhost.localdomain>
	<4703A9B4.6010507@freescale.com>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <013BB814-97D7-43AD-B588-936A34F26882@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH v3] qe: miscellaneous code improvements and fixes to the
	QE library
Date: Wed, 3 Oct 2007 09:43:26 -0500
To: Timur Tabi <timur@freescale.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Oct 3, 2007, at 9:39 AM, Timur Tabi wrote:

> Anton Vorontsov wrote:
>
>> Doubtfully, if changes are completely transparent. Because  
>> everything works
>> here without that cleanup.
>>
>> Ok, thanks anyway, will look further as time will permit.
>
> I did have one idea - the programming of the GUEMR register in  
> ucc_fast_init()
> could be wrong.  Can do a before/after comparison of the contents  
> of that
> register?

I'm dropping this patch from my tree till you guys figure this out.

- k
