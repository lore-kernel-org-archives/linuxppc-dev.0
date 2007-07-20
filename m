Return-Path: <scottwood@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 1B2C1DDEC1
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 21 Jul 2007 02:58:49 +1000 (EST)
Message-ID: <46A0E9BE.4020305@freescale.com>
Date: Fri, 20 Jul 2007 11:58:38 -0500
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: Misbah khan <misbah_khan@engineer.com>
Subject: Re: Kmalloc returns which address
References: <e5eb93010707160659m6a7d0b02p623542739d28ab29@mail.gmail.com>
	<11705981.post@talk.nabble.com>
In-Reply-To: <11705981.post@talk.nabble.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Misbah khan wrote:
> hi Suresh
> 
> In linux kmelloc returns the pointer to virtual address not the physical
> address, to return to the physical address there is different function
> called ioremap 
> 
> for eg :-
> char *buf_tx =kmalloc(100,GFP_KERNEL); // Tx buffer
> char *buf_rx=kmalloc(100,GFP_KERNEL); // Rx buffer
> 
> ptr_tx=ioremap( buf_tx,100);
> ptr_rx=ioremap(buf_rx,100);

That's a really easy way to cause a machine check.

-Scott
