Return-Path: <mh@omnisys.se>
Received: from ch-smtp02.sth.basefarm.net (ch-smtp02.sth.basefarm.net
	[80.76.149.213])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 3B94DDDE1E
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 16 Feb 2008 15:57:38 +1100 (EST)
Subject: Re: Frustrated question with insmod
From: Magnus Hjorth <mh@omnisys.se>
To: Bruce_Leonard@selinc.com
In-Reply-To: <OF994170A6.977C29F1-ON882573F1.0005A6C7-882573F1.00060311@selinc.com>
References: <OF994170A6.977C29F1-ON882573F1.0005A6C7-882573F1.00060311@selinc.com>
Content-Type: text/plain
Date: Sat, 16 Feb 2008 05:42:19 +0100
Message-Id: <1203136939.5231.0.camel@magnus-desktop>
Mime-Version: 1.0
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


'cat /proc/modules' perhaps?

//Magnus


On Fri, 2008-02-15 at 17:06 -0800, Bruce_Leonard@selinc.com wrote:
> Sorry if this is the wrong place to post this question.  I'm developing a 
> NAND flash driver and I need to do some detailed dubugging using GDB with 
> a BDI2K.  According to the Denx web site, to find out the address that the 
> module is loading at you load it using the -m parameter to insmod (i.e., 
> "insmod -m mymodule").  However, every version of insmod I've tried 
> doesn't recognize ANY options much less -m.  Can anyone please point me in 
> the right direction, or give me another way of knowing what the load 
> address of my module is?
> 
> Thanks.
> 
> Bruce
> _______________________________________________
> Linuxppc-embedded mailing list
> Linuxppc-embedded@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-embedded
