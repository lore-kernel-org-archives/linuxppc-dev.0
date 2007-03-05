Return-Path: <robertst@tihlde.org>
Received: from osl1smout1.broadpark.no (osl1smout1.broadpark.no [80.202.4.58])
	by ozlabs.org (Postfix) with ESMTP id 1C8C9DDF2A
	for <linuxppc-embedded@ozlabs.org>;
	Mon,  5 Mar 2007 22:21:55 +1100 (EST)
Received: from osl1sminn1.broadpark.no ([80.202.4.59])
	by osl1smout1.broadpark.no
	(Sun Java System Messaging Server 6.1 HotFix 0.05 (built Oct 21 2004))
	with ESMTP id <0JEF007ZGGWCZP20@osl1smout1.broadpark.no> for
	linuxppc-embedded@ozlabs.org; Mon, 05 Mar 2007 12:21:49 +0100 (CET)
Received: from [127.0.0.1] ([84.48.53.104]) by osl1sminn1.broadpark.no
	(Sun Java System Messaging Server 6.1 HotFix 0.05 (built Oct 21 2004))
	with ESMTP id <0JEF00JPBGWBTDC0@osl1sminn1.broadpark.no> for
	linuxppc-embedded@ozlabs.org; Mon, 05 Mar 2007 12:21:48 +0100 (CET)
Date: Mon, 05 Mar 2007 12:21:26 +0100
From: Robert Staven <robertst@tihlde.org>
Subject: Re: Getting the LED light up... (A&M Rattler 8250PCI linux 2.6.13-AM)
In-reply-to: <200703050927.05201.laurent.pinchart@technotrade.biz>
To: linuxppc-embedded@ozlabs.org
Message-id: <45EBFD36.1040801@tihlde.org>
MIME-version: 1.0
Content-type: text/plain; charset=ISO-8859-1; format=flowed
References: <45EAB26F.1060001@tihlde.org>
	<200703050927.05201.laurent.pinchart@technotrade.biz>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

 >> #define P0        0x8000 // P0 bit in registers
 >> #define P1        0x4000 // P1 bit in registers
 >> #define P2        0x2000 // P2 bit in registers
 >
 >
 > Shouldn't that be
 > #define P0        0x80000000 // P0 bit in registers
 > #define P1        0x40000000 // P1 bit in registers
 > #define P2        0x20000000 // P2 bit in registers
 > ?

<shamed>Hmmm, next time I'll better use my calculator figuring out how 
many digits there is in a 32bit hex number... :P </shamed>

Many thanks for the assistance Laurent! (the LED came to life)

And you all may have a good long laugh of me now, I deserve it! :)

br
Robert
