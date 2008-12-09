Return-Path: <jacmet@gmail.com>
Received: from ey-out-2122.google.com (ey-out-2122.google.com [74.125.78.27])
	by ozlabs.org (Postfix) with ESMTP id 8E292DDEEE
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 10 Dec 2008 08:18:47 +1100 (EST)
Received: by ey-out-2122.google.com with SMTP id 6so34315eyi.15
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 09 Dec 2008 13:18:44 -0800 (PST)
Sender: Peter Korsgaard <jacmet@gmail.com>
To: dhlii@dlasys.net
Subject: Re: Is anyone using the C67x00 USB Host ?
References: <49394978.10905@dlasys.net> <87r64j112j.fsf@macbook.be.48ers.dk>
	<493ED385.7070601@dlasys.net>
From: Peter Korsgaard <jacmet@sunsite.dk>
Date: Tue, 09 Dec 2008 22:11:44 +0100
In-Reply-To: <493ED385.7070601@dlasys.net> (David H. Lynch,
	Jr.'s message of "Tue\, 09 Dec 2008 15\:22\:29 -0500")
Message-ID: <87wse9m4tr.fsf@macbook.be.48ers.dk>
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

Hi,

 >> No activity on the interrupt pin or is it always active?
 >> 
 David> Neither:

 David> The USB system does not function with interrupts, and the
 David> kernel reports lots of unhandled IRQ's.

Of the correct IRQ number?

 David> I beleive that
 David> int_status = c67x00_ll_hpi_status(c67x00);
 David> if (!int_status)
 David> return IRQ_NONE;

 David> is always exiting IRQ_NONE;

That would be suprising if the c67x00 is triggering the interrupt.

 David> If I replace the request_irq() call with installation of a
 David> timer service routine that basically periodically calls the
 David> interrupt handler, everything works fine - albeit slowly.

And what does c67x00_ll_hpi_status() return in your timer routing?

-- 
Bye, Peter Korsgaard
