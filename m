Message-ID: <3757E499.32339D86@agelectronics.co.uk>
Date: Fri, 04 Jun 1999 15:37:13 +0100
From: Adrian Cox <apc@agelectronics.co.uk>
MIME-Version: 1.0
To: linuxppc-dev@lists.linuxppc.org
Subject: Re: Support for Motorola Platforms
References: <3757E59D.B18BCA8C@phx.mcd.mot.com>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Johnnie Peters wrote:
> Motorola has a new version of the MVME2400 with the MAX processor and
> as soon as I can get my hands on one I will do the work to get Linux
> to run on it.  Plans are also underway for new versions of the MTX
> series
> supporting the MAX processor.

Has anybody started work on GNU tools and kernel porting for Altivec
processors? The issues I see are:
(1) Altivec intructions in gas, so I don't have to enter the codes by
hand.
(2) Linux Kernel patches to load/save Altivec registers. These are large
enough that a lazy load/save might be useful.
(3) (Questionable) Patches to EGCS to support the C extensions that
Motorola specify in the Altivec PIM. I detest C extensions that add the
keyword "vector", but all Motorola's example code uses them.

All of these can be done based on documentation from Motorola's website.
I suspect that (1) has already happened inside some RTOS vendors, but
will take a long time to filter into the standard releases.

- Adrian Cox

[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
