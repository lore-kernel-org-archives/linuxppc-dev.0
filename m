Message-ID: <3BB501AD.60E3C8A0@mvista.com>
Date: Fri, 28 Sep 2001 18:03:09 -0500
From: Mark Hatle <fray@mvista.com>
MIME-Version: 1.0
To: "Prasad, Siva" <Siva.Prasad@smartm.com>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: Ramdisk: kernel panic...
References: <35C119252057D511BB9F0003476BF8A208E5CA@freexc01.smartm.com>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


> Freeing unused kernel memory: 180k init
> Kernel panic: Attempted to kill init!
>  <0>Rebooting in 180 seconds..

The message indicates it was unable to execute the init program.  Do you
have the required libraries in your ramdisk?  are they for the right
machine.. (remember cachelines are different between 8xx and the other
PPC processors.)

There are a lot of things that can cause init to bail, sigsegv, sigill,
etc, missing/bad library, etc..

--Mark

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
