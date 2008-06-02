Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id EEF2BDE7B2
	for <linuxppc-dev@ozlabs.org>; Tue,  3 Jun 2008 05:43:25 +1000 (EST)
Message-Id: <8945FFBA-5552-4CF4-B185-8FDD7885B744@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: Segher Boessenkool <segher@kernel.crashing.org>
In-Reply-To: <165963514fdb3980898f3babaad546a9@kernel.crashing.org>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v924)
Subject: Re: [PATCH] [POWERPC] 85xx: Add next-level-cache property
Date: Mon, 2 Jun 2008 14:43:14 -0500
References: <1212180199-968-1-git-send-email-galak@kernel.crashing.org>
	<1212180199-968-2-git-send-email-galak@kernel.crashing.org>
	<165963514fdb3980898f3babaad546a9@kernel.crashing.org>
Cc: ppc-dev list <linuxppc-dev@ozlabs.org>,
	Yoder Stuart <stuart.yoder@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On May 30, 2008, at 4:49 PM, Segher Boessenkool wrote:

>> Added next-level-cache to the L1 and a reference to the new L2 label.
>
> Where is this property defined?  I can't find it.
>
> The PowerPC binding defines an "l2-cache" property for this (it
> points from CPU node to L2 cache node, from L2 cache node to L3
> cache node, from L3 cache node to L4 cache node, etc.)

So looking at the PPC binding its not terrible clear about "l3-cache"  
being a valid property.  I believe the discussion w/ePAPR was to  
create something a bit more generic and clarify/update the PPC binding.

I'm going to stick with the new binding as we don't use this linking  
currently.

- k
