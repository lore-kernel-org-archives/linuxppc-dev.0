Message-Id: <s0891844.083@EMAIL>
Date: Fri, 23 Apr 2004 13:20:34 +0530
From: "Sanjeev R" <sanjeevr@myw.ltindia.com>
To: <wd@denx.de>
Cc: <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: MPC880 and ELDK
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Thanks for the information. Actually wanted to validate my assumptions and to make it doubly sure that i can look  for support from the list.

Thanks
Sanjeev

>>> Wolfgang Denk <wd@denx.de> 04/23/04 12:11AM >>>
In message <s088e797.066@EMAIL> you wrote:
>
>  Does  ELDK support  MPC880 arch? (linux distro in it)

The MPC880 is just  another  member  of  the  MPC8xx  family.  It  is
supported by the ppc_8xx packages in the ELDK.

> If yes , can i have some details on that?

See http://www.denx.de/ELDK.html

> If ELDK doesnt is there any other distro i can go for..?

I think your question is wrong. You don't need a new or special Linux
distribution for each new processor. What you need is  processor  and
board  support in U-Boot and the Linux kernel - but this is obviously
board dependent.

>  Since Uboot supports MPC885 i presume it has to support MPC880, coz except
>  for the extra security module and the SCC they dont differ a lot.

Tey are just like all the other 8xx processors.

Best regards,

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
"Unibus timeout fatal trap program lost sorry"  -  An  error  message
printed by DEC's RSTS operating system for the PDP-11


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
