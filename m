Return-Path: <dwh@ovro.caltech.edu>
Received: from ovro.ovro.caltech.edu (ovro.ovro.caltech.edu [192.100.16.2])
	by ozlabs.org (Postfix) with ESMTP id CB6C667AC5
	for <linuxppc-embedded@ozlabs.org>;
	Thu,  4 May 2006 02:06:47 +1000 (EST)
Message-ID: <4458D4FA.8090302@ovro.caltech.edu>
Date: Wed, 03 May 2006 09:06:18 -0700
From: David Hawkins <dwh@ovro.caltech.edu>
MIME-Version: 1.0
To: "Steve Iribarne (GMail)" <netstv@gmail.com>
Subject: Re: kernel debugging
References: <b4b98b690605030711q69426a59j28db8e38be73f1f0@mail.gmail.com>
In-Reply-To: <b4b98b690605030711q69426a59j28db8e38be73f1f0@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
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



> This is more a general question to see what others do out here.  I am
> begining to get sick of printk debugging.  I work on two different PPC
> boards.  An 860 and 8260.
> 
> I want to get some feedback on the best kernel debugger to use.  I
> have been looking at three.
> 
> 1.  kgdb
> 2.  kdb
> 3.  UML
> 
> I am leaning towards kgdb, but before I jump in I thought I'd put this
> out to the best group I could think of linuxppc.  Because I am sure
> most of you are using something!  :)

Hey Steve,

You've missed the most important one; a hardware debugger. I believe
most people using PPC use a BDI2000 from Abatron. They're about $3k.
I recently received one, but haven't had time to work on my PPC
stuff, so can't comment further. I'm sure everyone else on the
list will help with comments.

Note that if you use a bunch of different PPC cores, you need to
add $1k per core for the firmware uploads to the BDI2000. So if
you are working with say AMCC 440, Freescale e300/G2, e500, etc
you'll need a firmware image for each due to the debug core
differences (I guess).

The US distributor for the BDI2000 is Ultimate Solutions,
www.ultsol.com.

Cheers
Dave
