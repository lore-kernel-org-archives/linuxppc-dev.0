Return-Path: <salquint@gmail.com>
Received: from nz-out-0102.google.com (nz-out-0102.google.com [64.233.162.193])
	by ozlabs.org (Postfix) with ESMTP id 46AB367B35
	for <linuxppc-embedded@ozlabs.org>;
	Sun, 18 Jun 2006 11:32:21 +1000 (EST)
Received: by nz-out-0102.google.com with SMTP id i11so835207nzi
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 17 Jun 2006 18:32:20 -0700 (PDT)
From: "SalQ" <salquint@gmail.com>
To: <bennett78@digis.net>
Subject: RE: Using bestcomm in an external module (MPC5200B to be exact)
Date: Sat, 17 Jun 2006 18:26:02 -0700
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
In-Reply-To: <44944F9B.8060007@digis.net>
Message-ID: <4494abb0.4e348f87.34dd.ffffc85c@mx.gmail.com>
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

Thanks Frank, I actually have seen that, but it looks like an internal
module, not an external module... unless I'm missing something.  I've tried
configuring a few drivers that used bestcomm as <M>, and once I used insmod
on them they complained about all of the bestcomm API functions as missing.

________________________________

From: linuxppc-embedded-bounces+salquint=gmail.com@ozlabs.org
[mailto:linuxppc-embedded-bounces+salquint=gmail.com@ozlabs.org] On Behalf
Of Frank Bennett
Sent: Saturday, June 17, 2006 11:53 AM
To: Trueskew
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: Using bestcomm in an external module (MPC5200B to be exact)


Trueskew wrote: 

	I'm writing a driver for a TI codec attached to the MPC5200B PSC3
codec lines on a Lite5200b.  It's an external module, and I'd like to use
Bestcomm with it.  I've already tried a bunch of horrible things to get it
to work.  I could say it's close, but by close I mean the FEC still runs, my
stuff doesn't.  
	 
	1. Can the Bestcomm I/F be used by an external module, or is the
module required to be built in if built-in drivers use Bestcomm?
TasksInitAPI (no so bad) and TasksLoadImage (yeah, bad) aren't really
supposed to be called more than once from what I've read, and the kernel
loads them for ethernet and ATA (no disk in my system if that matters).  
	 
	2. If it can be used by an external module, how would I do it?  I've
tried compiling the source into my module and replicating the initialization
the kernel does in addition to my own stuff.  It's not too bad, though I
don't get any interrupts yet.
	 
	The LTIB from Freescale includes AIC23 and AC97 drivers that use
Bestcomm.  I built my kernel with them set as modules, and they had the same
unresolved problems that my driver has on insmod, so I'm pessimistic.  If
someone could put me out of my misery one way or another, I'd appreciate it.

Might check out the driver posted by Bob Petersen:
    http://ozlabs.org/pipermail/linuxppc-embedded/2005-September/020210.html
using DENX linuxppc_2_4_devel/arch/ppc/5xxx_io/  i2s.c, psc.c and Bestcomm/

Frank


	 
	Thanks.
	Sal
	 
	________________________________


	_______________________________________________
	Linuxppc-embedded mailing list
	Linuxppc-embedded@ozlabs.org
	https://ozlabs.org/mailman/listinfo/linuxppc-embedded

Frank Bennett
President

Mathegraphics,LLC
613 Bentley Pl
Fort Collins,CO 80526
970-229-9269 (hm) 970-402-9269 (cell)
www.mathegraphics.com
bennett78@digis.net
