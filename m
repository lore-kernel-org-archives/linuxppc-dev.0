Return-Path: <olh@suse.de>
Received: from mx1.suse.de (ns.suse.de [195.135.220.2])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx1.suse.de",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 2993967A06
	for <linuxppc-dev@ozlabs.org>; Fri,  3 Mar 2006 22:06:26 +1100 (EST)
Date: Fri, 3 Mar 2006 12:06:20 +0100
From: Olaf Hering <olh@suse.de>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: incorrect rmo_top handling in prom_init
Message-ID: <20060303110620.GA5130@suse.de>
References: <20060302185509.GA14235@suse.de>
	<1141342541.13565.6.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <1141342541.13565.6.camel@localhost.localdomain>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

 On Fri, Mar 03, Benjamin Herrenschmidt wrote:

> On Thu, 2006-03-02 at 19:55 +0100, Olaf Hering wrote:
> > My iBook1 has 2 memory regions in reg. Depending on how I boot it
> > (vmlinux+initrd) or zImage.initrd, it will not boot with current Linus
> > tree.
> > rmo_top should be 160MB instead of 32MB.
> 
> Does that fix it ?

My G5 may need similar tweaks. looking.


0 > dev /memory .properties 
name                    memory
device_type             memory
reg                     00000000 00000000  10000000 
                        00000000 00000000  00000000 
                        00000000 00000000  00000000 
                        00000000 00000000  00000000 
                        00000000 00000000  00000000 
                        00000000 00000000  00000000 
                        00000000 00000000  00000000 
                        00000000 00000000  00000000 
slot-names              0000000f
                        DIMM0/J11
                        DIMM1/J12
                        DIMM2/J13
                        DIMM3/J14
available               00003000 0fbf9000 
bank-names              0000000f
                        64 bit Bank0/J11/J12/front
                        64 bit Bank1/J11/J12/back
                        64 bit Bank2/J13/J14/front
                        64 bit Bank3/J13/J14/back
bank-sizes              10000000 00000000 00000000 00000000 
dimm-info               8008070d 09014000 04607000 82100001 0e040c01 0220c075 
                        70000048 30482a20 75754545 00000000 003c4830 2d550000 
                        00000000 00000000 00000000 000000e7 ad000000 00000000 
                        0148594d 44323136 20363436 41364a2d 4a202041 41033432 
                        06873900 00000000 00000000 00000000 00000000 00000000 
                        00000000 00000000 8008070d 09014000 04607000 82100001 
                        0e040c01 0220c075 70000048 30482a20 75754545 00000000 
                        003c4830 2d550000 00000000 00000000 00000000 000000e7 
                        ad000000 00000000 0148594d 44323136 20363436 41364a2d 
                        4a202041 41033432 06863800 00000000 00000000 00000000 
                        00000000 00000000 00000000 00000000 
                        ... 00000200 bytes total
dimm-types              DDR SDRAM
                        DDR SDRAM
                        
                        
dimm-speeds             PC2700U-25330
                        PC2700U-25330
                        
                        
ram-layout-architecture 00000001 

 ok
