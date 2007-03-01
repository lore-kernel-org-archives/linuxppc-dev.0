Return-Path: <Bruce_Leonard@selinc.com>
In-Reply-To: <200703011101.20116.frank.bodammer@hs.gcd-erlangen.de>
To: Frank Bodammer <frank.bodammer@hs.gcd-erlangen.de>
Subject: Re: Kernel support for the TI1520 PCI-CardBus bridge?
MIME-Version: 1.0
Message-ID: <OF2A2BDD6B.6E8EF202-ON88257291.006A3B74-88257291.006ADC4D@selinc.com>
From: Bruce_Leonard@selinc.com
Date: Thu, 1 Mar 2007 11:27:17 -0800
Content-Type: text/plain; charset="US-ASCII"
Cc: linuxppc-embedded-bounces+brucle=selinc.com@ozlabs.org,
	linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi Frank,

linuxppc-embedded-bounces+brucle=selinc.com@ozlabs.org wrote on 03/01/2007 
02:01:19 AM:

> On Thursday 01 March 2007 02:35, Bruce_Leonard@selinc.com wrote:
> > Hi all,
> >
> > We're designing a new product and we want to put a CF card in it. 
We're
> 
> I got a TI  cardbus controller PCI1520IPDV working in a embedded PPC 
> system with little modifications to kernel 2.4.25, but i didn't 
> found a common 
> configuration for the I/O-space that works for all type of cards 
> (cardbus and 
> pcmcia). I tested some pcmcia cards, like WLAN, Ethernet, pcmcia 
harddisk 
> and CF-Adapter with a different kernel configuration as for cardbus 
cards. 
> 
> Frank
> _______________________________________________
> Linuxppc-embedded mailing list
> Linuxppc-embedded@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-embedded

Thanks for the reply.  So it sounds like if you got it working in 2.4.25, 
there's probably better support in the current kernel.  How much work did 
you have to do?  You say 'little modifications'.  Was it a few hours, 
days, or weeks?  Based on what I've found so far (and my admittedly naive 
understanding of pcmcia and the kernel), it looks like this should almost 
be plug and play.  Turn on the the yenta pcmcia driver and tell it to look 
for TI parts.  The TI1520 is alredy listed in pci_ids.h so it may be that 
it'll just work.  We're just looking for a warm fuzzy before we commit to 
this part since we're getting no help from TI on it.  And if we can't find 
a warm fuzzy will look at something else.  Thanks again.

Take care and stay safe.

bruce
