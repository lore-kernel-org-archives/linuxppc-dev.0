Return-Path: <scottwood@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id B02A6DE1D0
	for <linuxppc-dev@ozlabs.org>; Thu, 10 Jan 2008 06:30:41 +1100 (EST)
Message-ID: <478520E4.1050204@freescale.com>
Date: Wed, 09 Jan 2008 13:30:44 -0600
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH] [POWERPC] Fix handling of memreserve if the range lands
	in highmem
References: <Pine.LNX.4.64.0801091127400.8069@blarg.am.freescale.net>
	<20080109185349.GC4337@loki.buserror.net>
	<3B831CF0-E978-42E7-BA26-7598BC27A5F6@kernel.crashing.org>
In-Reply-To: <3B831CF0-E978-42E7-BA26-7598BC27A5F6@kernel.crashing.org>
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

Kumar Gala wrote:
> On Jan 9, 2008, at 12:53 PM, Scott Wood wrote:
>> It looks like if the reserved area straddles the highmem boundary, it'll
>> only reserve the highmem portion.
> 
> Yeah, I thought about that.  I'm wondering if we should warn about 
> this.. its seems like a bad thing to do.

How is the firmware supposed to know where Linux sets its lowmem limit? 
  I think this is something that needs to be handled.

-Scott
