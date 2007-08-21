Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from e35.co.us.ibm.com (e35.co.us.ibm.com [32.97.110.153])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e35.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 5B80CDDEE2
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 21 Aug 2007 22:58:11 +1000 (EST)
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com
	[9.17.195.106])
	by e35.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id l7LCvwXU011967
	for <linuxppc-embedded@ozlabs.org>; Tue, 21 Aug 2007 08:57:58 -0400
Received: from d03av01.boulder.ibm.com (d03av01.boulder.ibm.com [9.17.195.167])
	by d03relay04.boulder.ibm.com (8.13.8/8.13.8/NCO v8.5) with ESMTP id
	l7LCvvrg218334
	for <linuxppc-embedded@ozlabs.org>; Tue, 21 Aug 2007 06:57:57 -0600
Received: from d03av01.boulder.ibm.com (loopback [127.0.0.1])
	by d03av01.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l7LCvvlC016605
	for <linuxppc-embedded@ozlabs.org>; Tue, 21 Aug 2007 06:57:57 -0600
Date: Tue, 21 Aug 2007 07:57:56 -0500
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: "Stelios Koroneos" <stelios@stelioscellar.com>
Subject: Re: Xilinx Virtex4 FX PPC
Message-ID: <20070821075756.6ca873d0@weaponx.rchland.ibm.com>
In-Reply-To: <HOECLKEKOHLAMMGDLLBHEEGHMAAA.stelios@stelioscellar.com>
References: <1187625654.6336.28.camel@PisteOff>
	<HOECLKEKOHLAMMGDLLBHEEGHMAAA.stelios@stelioscellar.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
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

On Tue, 21 Aug 2007 11:52:35 +0300
"Stelios Koroneos" <stelios@stelioscellar.com> wrote:

> > Question 1:
> > Do I need a special glibc for the Xilinx PPC 405????
> 
> FYI we are at the last stage of implementing OpenEmbedded support for the
> Xilinx ml403 (and hopefully other Xilinx boards in the near future)

Cool.

> It also handles the EDK header copying procedure "automagically" i.e you
> point to your EDK project dir and pulls the file(s) it needs for the kernel.
> We will be working to "automate" the generation of ACE files also, since OE
> generates a full image (kernel+fs) and not just the toolchain.
> Currently toolchain is gcc 4.1.1 with glibc 2.5 and/or uclibc 0.9.28.
> There is some work done by other OE developers to get eglibc going (omap
> works according to the latest info i have)
> 
> OpenEmbedded supports a number of ppc targets currently walnut
> (405),sequoia(440e),efika(603e) just to mention a few
> 
> I will be speaking at the Power.org dev conference about OE and power
> architecure so if anyone will be there and wishes to get some knowledge
> about OE in "advance" , feel  free to drop me a mail, as we will releasing a
> beta of our OE based distro soon.

I'm hoping to attend as well.  Should be interesting.

josh
