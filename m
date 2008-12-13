Return-Path: <dhlii@dlasys.net>
Received: from outbound-mail-310.bluehost.com (outbound-mail-310.bluehost.com
	[67.222.54.3]) by ozlabs.org (Postfix) with SMTP id 8834ADE088
	for <linuxppc-embedded@ozlabs.org>;
	Sun, 14 Dec 2008 05:48:47 +1100 (EST)
Message-ID: <494401F3.2050005@dlasys.net>
Date: Sat, 13 Dec 2008 13:41:55 -0500
From: "David H. Lynch Jr." <dhlii@dlasys.net>
MIME-Version: 1.0
To: linuxppc-embedded <linuxppc-embedded@ozlabs.org>
Subject: Re: Is anyone using the C67x00 USB Host ?
References: <49394978.10905@dlasys.net>
	<493D2B22.4000601@seznam.cz>	<493ED4B6.7010605@dlasys.net>
	<493F89F2.60702@seznam.cz>	<87iqpsme9j.fsf@macbook.be.48ers.dk>
	<493FD3EC.3060305@seznam.cz> <87wse8m6p0.fsf@macbook.be.48ers.dk>
	<493FEFA7.9050703@seznam.cz>
In-Reply-To: <493FEFA7.9050703@seznam.cz>
Content-Type: text/plain; charset=ISO-8859-1
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

	Worked out the interrupt problem - the FPGA parameters for the USB
interrupt were wrong.

	But I still can not get host 1B working. Any sugestions as to something
I can look at ?





-- 
Dave Lynch 					  	    DLA Systems
Software Development:  				         Embedded Linux
717.627.3770 	       dhlii@dlasys.net 	  http://www.dlasys.net
fax: 1.253.369.9244 			           Cell: 1.717.587.7774
Over 25 years' experience in platforms, languages, and technologies too
numerous to list.

"Any intelligent fool can make things bigger and more complex... It
takes a touch of genius - and a lot of courage to move in the opposite
direction."
Albert Einstein
