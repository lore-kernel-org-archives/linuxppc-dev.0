To: "Raghav K" <raghavk@myw.ltindia.com>
Cc: "<LinuxPPC" <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: Issues with raw write using MTD Char Driver 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Wed, 18 Aug 2004 18:59:21 +0530."
             <s123a722.007@EMAIL>
Date: Wed, 18 Aug 2004 16:54:23 +0200
Message-Id: <20040818145428.09175C109F@atlas.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


In message <s123a722.007@EMAIL> you wrote:
>
> Hi, I  have 8MB AMD29FXX flash organized as  16 chips of 0.5 MB each as DIMM package on a
> MPC885 board. The same is accessed as a 4 x 2MB interleaved flash, of effective sector size
> 256k. I'm using the  MTD concatation option to interleave thes chips. I'm using Arabella Linux,
> kernel 2.4.25.

Why are you posting the same  messages  to  different  mailing  lists
(like the MTD list and this one)?


Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
"Plan to throw one away.  You will anyway."
                              - Fred Brooks, "The Mythical Man Month"

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
