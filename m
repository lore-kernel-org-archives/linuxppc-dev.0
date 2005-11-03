Return-Path: <dan@embeddededge.com>
Received: from penguin.netx4.com (embeddededge.com [209.113.146.155])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 709C768621
	for <linuxppc-embedded@ozlabs.org>;
	Thu,  3 Nov 2005 15:24:14 +1100 (EST)
In-Reply-To: <000901c5e017$91aef880$6405a8c0@absolut>
References: <000901c5e017$91aef880$6405a8c0@absolut>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <4b172607a67f8ad6a9ba20bf0cb0371b@embeddededge.com>
From: Dan Malek <dan@embeddededge.com>
Date: Wed, 2 Nov 2005 23:30:11 -0500
To: "Absolut Hunter" <absoluthunter@comcast.net>
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: SM501 Frame Buffer driver on PPC
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


On Nov 2, 2005, at 8:40 PM, Absolut Hunter wrote:

> Has anyone used the SM501 driver with this type of NON-Unified memory
> architecture?

What do you mean, non-unified?

>  I am guessing this can be confusing to the driver since the
> frame buffer registers inside the SM501 need to be using offset ZERO 
> instead
> of the 0xF8000000 like the MPC8280 sees.

The SM501 PCI driver assumes the addresses are from the PCI
base address, not from zero.   Properly using the local bus address
in a similar way should work just fine.

Thanks.

	-- Dan
