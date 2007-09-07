Return-Path: <segher@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 5F9B3DDEFC
	for <linuxppc-dev@ozlabs.org>; Sat,  8 Sep 2007 02:30:51 +1000 (EST)
In-Reply-To: <20070907153116.GA15770@ld0162-tx32.am.freescale.net>
References: <11891624353752-git-send-email-wei.zhang@freescale.com>
	<1189162437484-git-send-email-wei.zhang@freescale.com>
	<3b29878a7d3d1b14f84b5d3b182cdb98@kernel.crashing.org>
	<20070907153116.GA15770@ld0162-tx32.am.freescale.net>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <2e143fec3dc983f2ab4565f3bdc84d23@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH 1/5] Add Freescale DMA and DMA channel to
	Documentation/powerpc/booting-without-of.txt file.
Date: Fri, 7 Sep 2007 18:30:44 +0200
To: Scott Wood <scottwood@freescale.com>
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

>> Those don't agree.  It's probably best to describe the whole
>> DMA controller register block in this node.  Why do you need
>> subnodes for the channels at all?
>
> The channels have separate registers and sometimes separate interrupts 
> --
> it's simpler to bind to a channel at a time than to parse a list of reg
> blocks and interrupts.  It's also more flexible in case a new chip 
> comes
> out with more/fewer channels, or if certain channels are not general
> purpose.

I don't see this as more flexible, but no problem, it will work
for sure.

The "reg" vs. textual unit address issue needs to be solved though.


Segher
