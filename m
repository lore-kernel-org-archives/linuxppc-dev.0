Return-Path: <frank.bodammer@gcd-solutions.de>
Received: from relay1.global.de (relay1.global.de [217.64.163.3])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "localhost", Issuer "www.qmailtoaster.com" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 61CE7DDEC5
	for <linuxppc-embedded@ozlabs.org>;
	Thu,  1 Mar 2007 21:08:50 +1100 (EST)
From: Frank Bodammer <frank.bodammer@hs.gcd-erlangen.de>
To: linuxppc-embedded@ozlabs.org
Subject: Re: Kernel support for the TI1520 PCI-CardBus bridge?
Date: Thu, 1 Mar 2007 11:01:19 +0100
References: <OFB8991C41.CAB80F63-ON88257291.0008226D-88257291.0008B663@selinc.com>
In-Reply-To: <OFB8991C41.CAB80F63-ON88257291.0008226D-88257291.0008B663@selinc.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200703011101.20116.frank.bodammer@hs.gcd-erlangen.de>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Thursday 01 March 2007 02:35, Bruce_Leonard@selinc.com wrote:
> Hi all,
>
> We're designing a new product and we want to put a CF card in it.  We're
> thinking the easiest way to do that is to put in a PCI-CF bridge and we
> would like to use the TI1520 because it's industrial rated which we need.
> We can get the parts but TI is refusing to give us any support because
> they're devoting 100% of their time to dealing with the Vista release. I'm
> curious if anyone has ever successfully gotten this part to work in linux.
>  I found it listed in pci_ids.h, but that doesn't mean it's actually
> used/working.  I'm not looking for a detailed explination right now, we're
> just trying to gage if this part would be a couple of weeks of work or a
> couple of months.  Thanks for any info.

I got a TI  cardbus controller PCI1520IPDV working in a embedded PPC 
system with little modifications to kernel 2.4.25, but i didn't found a common  
configuration for the I/O-space that works for all type of cards (cardbus and  
pcmcia). I tested some pcmcia cards, like WLAN, Ethernet, pcmcia harddisk 
and CF-Adapter with a different kernel configuration as for cardbus cards. 

Frank
