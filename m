Message-Id: <l03130300b4cb698e36a7@[24.218.140.90]>
In-Reply-To: <38A5934B.9E259106@schweiz.org>
References: <Pine.LNX.4.10.10002112021310.4195-100000@xpol.uchicago.edu>
 <00021218294101.09715@argo.linuxcare.com.au>
 <00021211003504.00821@linux.eric.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Date: Sat, 12 Feb 2000 14:53:22 -0500
To: a.tobler@schweiz.org
From: "Michael R. Zucca" <mrz5149@acm.org>
Subject: Re: 2.3.43 failed
Cc: Eric Benard <ebenard@ifrance.com>, Paul Mackerras <paulus@linuxcare.com>,
        ramp@oddjob.uchicago.edu, linuxppc-dev@lists.linuxppc.org
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


At 12:07 PM -0500 2/12/00, Catherine & Andreas wrote:

>> > My rsync tree at linuxcare.com.au::linux-pmac-devel is at 2.3.44-pre8, it
>> > should compile and run just fine on an iMac.
>>
>> it compiles fine on a B&W G3 but doesn't run : it stops after the
>>"Booting..."
>> message.

This is the same problem I had with 2.2.14 on my PowerCenter 132. I just
compiled a recent rsync of the linux-pmac-devel tree and had the same hang.

I think it has something to do with the boot environment. When I boot under
MacOS 9 with the BootX application, the boot will only get as far as
"Booting..." and then some registers (i.e. never get to Tux and the linux
boot info). However, if I boot using the BootX extension instead, the
kernel will get to boot and run the kernel but then it crashes with a
machine check. I think the crash is happening in the serial driver, or the
sound driver. I can't tell which for sure yet. I'd like to try booting
right out of OF to see if that changes anything.

Did we change something about the way we setup memory early in the boot
process after 2.2.12 because the 2.2.12 kernel that came with my Yellowdog
distribution works just great out of BootX.

Thanks!

____________________________________________________________________
 Michael Zucca - mrz5149@acm.org - http://www.mdc.net/~mrz5149/
 "I will choose a path that's clear. I will choose Freewill. "
  --Rush, Freewill
____________________________________________________________________


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
