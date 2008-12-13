Return-Path: <jacmet@gmail.com>
Received: from ey-out-2122.google.com (ey-out-2122.google.com [74.125.78.25])
	by ozlabs.org (Postfix) with ESMTP id 5E84FDE0DC
	for <linuxppc-embedded@ozlabs.org>;
	Sun, 14 Dec 2008 05:58:20 +1100 (EST)
Received: by ey-out-2122.google.com with SMTP id 6so306331eyi.15
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 13 Dec 2008 10:58:17 -0800 (PST)
Sender: Peter Korsgaard <jacmet@gmail.com>
To: "David H. Lynch Jr." <dhlii@dlasys.net>
Subject: Re: Is anyone using the C67x00 USB Host ?
References: <49394978.10905@dlasys.net> <493D2B22.4000601@seznam.cz>
	<493ED4B6.7010605@dlasys.net> <493F89F2.60702@seznam.cz>
	<87iqpsme9j.fsf@macbook.be.48ers.dk> <493FD3EC.3060305@seznam.cz>
	<87wse8m6p0.fsf@macbook.be.48ers.dk> <493FEFA7.9050703@seznam.cz>
	<494401F3.2050005@dlasys.net>
From: Peter Korsgaard <jacmet@sunsite.dk>
Date: Sat, 13 Dec 2008 19:58:16 +0100
In-Reply-To: <494401F3.2050005@dlasys.net> (David H. Lynch,
	Jr.'s message of "Sat\, 13 Dec 2008 13\:41\:55 -0500")
Message-ID: <87fxkrgawn.fsf@macbook.be.48ers.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linuxppc-embedded <linuxppc-embedded@ozlabs.org>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

>>>>> "David" == David H Lynch <dhlii@dlasys.net> writes:

 David> 	Worked out the interrupt problem - the FPGA parameters
 David> for the USB interrupt were wrong.

Ahh.

 David> But I still can not get host 1B working. Any sugestions as to
 David> something I can look at ?

Not right away. All the platforms I have been using have only used
port 1A, so there could potentially be a mistake in the driver /
firmware.

-- 
Bye, Peter Korsgaard
