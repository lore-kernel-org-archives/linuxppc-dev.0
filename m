Return-Path: <kumar.gala@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102]) by ozlabs.org (Postfix) with ESMTP id AFB1567B6A
	for <linuxppc-dev@ozlabs.org>; Thu, 30 Jun 2005 15:06:38 +1000 (EST)
In-Reply-To: <1120089411.31924.36.camel@gaston>
References: <1120089411.31924.36.camel@gaston>
Mime-Version: 1.0 (Apple Message framework v730)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <3FD36254-F985-4040-A68A-72EEB212D8A3@freescale.com>
From: Kumar Gala <kumar.gala@freescale.com>
Date: Thu, 30 Jun 2005 00:06:38 -0500
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: linuxppc-dev@ozlabs.org
Subject: Re: set_phys_avail() futures question
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Jun 29, 2005, at 6:56 PM, Benjamin Herrenschmidt wrote:

> On Wed, 2005-06-29 at 16:14 -0500, Jon Loeliger wrote:
>
>> Ben (primarily),
>>
>> I'd like to get your opinion on what the future of
>> arch/ppc/mm/init.c/set_phys_avail() looks like.
>> Currently, its job is to traverse the mem_pieces data
>> and remove a whole series of #ifdef'ed regions of
>> memory based on configuration options.  These regions
>> are the initrd, the RTAS data, and the AGP special page.
>>
>> Do you see these regions as being explicitly listed in
>> the proposed  "reserved memory blocks" area of the Flat
>> Dev Tree header structure?
>>
>
> Yes. initrd for sure, RTAS too, AGP special page well ... I have to
> check if we still use that one at all... but it's not allocated in
> prom_init so it may need it's own little bit here still.

What this implies to me is that what a flattened OF tree we will no  
longer need to call set_phys_avail().

- kumar
