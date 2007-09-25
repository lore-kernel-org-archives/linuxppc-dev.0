Return-Path: <segher@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id E3E94DDDF8
	for <linuxppc-dev@ozlabs.org>; Wed, 26 Sep 2007 05:20:43 +1000 (EST)
In-Reply-To: <46F94E10.40906@freescale.com>
References: <46F94E10.40906@freescale.com>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <0bac9879b0e596fb22c87f28165a2335@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: Local bus binding
Date: Tue, 25 Sep 2007 21:20:01 +0200
To: Scott Wood <scottwood@freescale.com>
Cc: "linuxppc-dev@ozlabs.org list" <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> Segher,
> Kumar said he wants an ack from you on the local bus node binding 
> before he applies it -- can you review this patch?
>
> http://patchwork.ozlabs.org/linuxppc/patch?id=13591

As discussed on IRC a bit already...

- All three "should"s should be "typically"s.
- The relevant values for "compatible" should be included.
- It is wrong to require the localbus node to be a direct child of
   the root node.  This isn't in the binding /per se/, but both the
   commit message and the code do mention it.


Segher
