Message-Id: <5.1.0.14.2.20030108064518.025dfc08@falcon.si.com>
Date: Wed, 08 Jan 2003 06:47:39 -0500
To: linuxppc-embedded@lists.linuxppc.org
From: Jerry Van Baren <gerald.vanbaren@smiths-aerospace.com>
Subject: Re: BDI-2000
In-Reply-To: <0065D0B7.C21188@alloptic.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


You are setting your breakpoint at 0x0c000000.  Linux in virtual memory
starts at 0xc0000000.  Am I missing something?

gvb


At 04:40 PM 1/7/2003 -0500, cecilia.muaddi@alloptic.com wrote:

>Hello,
>
>I finally got my BDI-2000 for PPC 860 this week, and tried to set it up to
>debug my MMU problem.
>This is my first time using the BDI-2000, and really hope someone here can
>give me a hand.

[snip]

>I am able to check and modify the SRAM (at physical address location 0x0).
>and view the bootROM memory
>(at physical address of 0x28000000).  I enable the MMU XLAT and set the
>PTBASE to 0xf0 as suggested in the
>user manual.
>Here is the output of the BDI
>
>BDI>reset
>- TARGET: processing user reset request
>- TARGET: resetting target passed
>- TARGET: processing target init list ....
>- TARGET: processing target init list passed
>BDI>bi 0x0c000000 0x0c00ffff
>Breakpoint identification is 0
>BDI>go 0x28000100
>- TARGET: target has entered debug mode
>BDI>ci
>BDI>info
>     Target state      : debug mode
>     Debug entry cause : entering check stop state
>     Current PC        : 0x00000220
>BDI>
>
>I never seem to get the break at the location of 0x0c000000.
>The same problem if I set the break at location of start_here grep from
>System.map
>
>However I do get the break if I set at address location of 0 (start of the
>head_8xx.S)
>Can someone help me out here??
>
>Thanks
>
>Cecilia
>
>P.S. here is a brief information of my .cfg file which I loaded to BDI

[snip]


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
