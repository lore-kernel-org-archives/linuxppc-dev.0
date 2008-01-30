Return-Path: <bounces@nabble.com>
Received: from kuber.nabble.com (kuber.nabble.com [216.139.236.158])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id AE255DDE0A
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 30 Jan 2008 22:10:21 +1100 (EST)
Received: from isper.nabble.com ([192.168.236.156])
	by kuber.nabble.com with esmtp (Exim 4.63)
	(envelope-from <bounces@nabble.com>) id 1JKApd-0004qy-L9
	for linuxppc-embedded@ozlabs.org; Wed, 30 Jan 2008 03:10:17 -0800
Message-ID: <15179875.post@talk.nabble.com>
Date: Wed, 30 Jan 2008 03:10:17 -0800 (PST)
From: greenlean <jmgomez@atc.ugr.es>
To: linuxppc-embedded@ozlabs.org
Subject: Re: linux @ xup
In-Reply-To: <568740669@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
References: <568740669@web.de>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


Hi, 

You should set the Software/Software Platforms Settings/Os and Libraries/
UART16550 bus clock freq to the Bus Speed to 100000000 usually, this is the
OPB bus speed. And in Core_Clock_Frequency you insert the PLB bus speed.

You don't have to edit manually the file xparameters_ml300.h. 

If your are using Grant's kernel, from secretlab git, you should name the
file xparameters_ml300.h.
If your using the xilinx kernel you could change the name of the file and
use xparameters_xupv2p.h but you have to select this platform in the kernel
configuration...

I don't know if your asking for this, but I wish it could help.

Bye.


Joachim Meyer wrote:
> 
> Hi
> 
> I already succeded in setting up a Linux for the ml310. I'm trying to do
> it for the XUP Board now. The Problem I have is, that
> in every HowTo I read I should set at the EDK's software settings under
> Library/OS Parameters:
> Set PLB_CLOCK_FREQ_HZ to the PLB speed (usually 100000000)
> 
> But I can't find where to set it. With the ml310 there was this option.
> I'm using the EDK Board Definition File (.xbd), Pcores & Drivers from
> Xilinx:
> http://www.xilinx.com/univ/xupv2p.html
> EDK Version 9.1 SP2
> 
> If I ignore it and build the BSP there comes out an xparameters_ml300.h
> file which I copy to my Kernel sources.
> When I try to compile, I get errors that the PLB_CLOCK_FREQ_HZ isn't
> defined.
> Can I just add it to the xparameters_ml300.h file file (which I rename
> "xparameters_xupv2p.h") by Hand?
> 
> Greez and thx
> Joachim
> _________________________________________________________________________
> In 5 Schritten zur eigenen Homepage. Jetzt Domain sichern und gestalten! 
> Nur 3,99 EUR/Monat! http://www.maildomain.web.de/?mc=021114
> 
> _______________________________________________
> Linuxppc-embedded mailing list
> Linuxppc-embedded@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-embedded
> 
> 

-- 
View this message in context: http://www.nabble.com/linux-%40-xup-tp15179005p15179875.html
Sent from the linuxppc-embedded mailing list archive at Nabble.com.
