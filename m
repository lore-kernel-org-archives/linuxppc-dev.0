Return-Path: <Bruce_Leonard@selinc.com>
Received: from tesla.selinc.com (tesla.selinc.com [12.110.71.2])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "tesla.selinc.com", Issuer "RSA Data Security,
	Inc." (verified OK)) by ozlabs.org (Postfix) with ESMTP id 4D24BDDE18
	for <linuxppc-embedded@ozlabs.org>;
	Sun, 17 Feb 2008 19:03:33 +1100 (EST)
In-Reply-To: <1203136939.5231.0.camel@magnus-desktop>
To: Magnus Hjorth <mh@omnisys.se>
Subject: Re: Frustrated question with insmod
MIME-Version: 1.0
Message-ID: <OFE029FE92.B8F9D4B0-ON882573F2.002B93E9-882573F2.002C385D@selinc.com>
From: Bruce_Leonard@selinc.com
Date: Sun, 17 Feb 2008 00:03:25 -0800
Content-Type: text/plain; charset="US-ASCII"
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

> 
> 'cat /proc/modules' perhaps?

I tried that, but it gives me an odd address (at least I think it's an odd 
address): 0xE1188000.  I use that address in GDB for adding the symbol 
table (i.e., add-symbol-file mymodule 0xE1188000), but then the BDI 
reports "*** MMU: address translation for 0xE118822C failed" when I try to 
set a breakpoint in the probe function.  Admittedly I'm new to driver 
writing, but shouldn't the address be somewhere in the 0xC0xxxxxx range?

> 
> //Magnus
> 
> 
> On Fri, 2008-02-15 at 17:06 -0800, Bruce_Leonard@selinc.com wrote:
> > Sorry if this is the wrong place to post this question.  I'm 
developing a 
> > NAND flash driver and I need to do some detailed dubugging using GDB 
with 
> > a BDI2K.  According to the Denx web site, to find out the address that 
the 
> > module is loading at you load it using the -m parameter to insmod 
(i.e., 
> > "insmod -m mymodule").  However, every version of insmod I've tried 
> > doesn't recognize ANY options much less -m.  Can anyone please point 
me in 
> > the right direction, or give me another way of knowing what the load 
> > address of my module is?
> > 
> > Thanks.
> > 
> > Bruce
> > _______________________________________________
> > Linuxppc-embedded mailing list
> > Linuxppc-embedded@ozlabs.org
> > https://ozlabs.org/mailman/listinfo/linuxppc-embedded
> 
