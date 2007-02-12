Return-Path: <scottwood@freescale.com>
Received: from de01egw02.freescale.net (de01egw02.freescale.net
	[192.88.165.103]) by ozlabs.org (Postfix) with ESMTP id 66F2ADDE16
	for <linuxppc-dev@ozlabs.org>; Tue, 13 Feb 2007 03:45:41 +1100 (EST)
Message-ID: <45D09993.9050903@freescale.com>
Date: Mon, 12 Feb 2007 10:45:07 -0600
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: "Mark A. Greer" <mgreer@mvista.com>
Subject: Re: [PATCH 18/19] bootwrapper: Add xlate_reg(), and use it to find
	serial registers.
References: <20070207230017.GA3758@ld0162-tx32.am.freescale.net>
	<20070207230145.GR3849@ld0162-tx32.am.freescale.net>
	<20070209230700.GC12035@mag.az.mvista.com>
In-Reply-To: <20070209230700.GC12035@mag.az.mvista.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Mark A. Greer wrote:
> On Wed, Feb 07, 2007 at 05:01:45PM -0600, Scott Wood wrote:
> 
>>xlate_reg() uses the ranges properties of a node's parentage to find the
>>absolute physical address of the node's registers.
>>
>>The ns16550 driver uses this when no virtual-reg property is found.
> 
> 
> Is this necessary?  Shouldn't there always be a virtual-reg?

None of the dts files in the kernel tree currently have such a property...

-Scott
