To: "Sanjeev R" <sanjeevr@myw.ltindia.com>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: MPC880 and ELDK 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Fri, 23 Apr 2004 09:52:59 +0530."
             <s088e797.066@EMAIL>
Date: Fri, 23 Apr 2004 09:11:22 +0200
Message-Id: <20040423071128.1B2EFC133F@atlas.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


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
