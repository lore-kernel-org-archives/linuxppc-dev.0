Mime-Version: 1.0
Message-Id: <v04220800b617c2625f6f@[10.0.0.42]>
In-Reply-To: <v03110700b6174de92f96@[64.229.14.199]>
References: <v03110700b6174de92f96@[64.229.14.199]>
Date: Sat, 21 Oct 2000 15:04:18 -0700
To: "Kevin B. Hendricks" <khendricks@ivey.uwo.ca>,
        linuxppc-dev@lists.linuxppc.org
From: "Timothy A. Seufert" <tas@mindspring.com>
Subject: Re: Support for G4 ZIF upgrades in B+W G3 rev2
Content-Type: text/plain; charset="us-ascii" ; format="flowed"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


At 9:45 AM -0400 10/21/00, Kevin B. Hendricks wrote:
>Hi,
>
>I want to upgrade my development box.
>
>Does PPC Linux work well with G4 ZIF upgrades used in B+W G3 rev 2 systems?
>I read something about Apple firmware upgrades that prevent this
>combination from working?

Apple's later firmware version(s) for the B&W do not work with G4
CPUs.  If you have a rev 2 system, you have the affected firmware.
The vendors which ship ZIF upgrades for B&W computers include a
utility to patch the firmware so that you can boot the machine with a
G4.

>Does this effect Linux on PPC?  Does it affect Mac OSX?

It shouldn't affect Linux at all.  As long as the firmware
successfully initialized the CPU, the kernel is happy.  Dunno about
MacOS X, but my guess is that it should work too.

   Tim Seufert

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
