To: "El Topo" <ElTopo@myrealbox.com>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: ppcboot 2.0.0 + ppclinux2.4.devel, network weirdo 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Wed, 09 Apr 2003 01:46:27 PDT."
             <000d01c2fe74$83264520$1464a8c0@sjeng3>
Date: Wed, 09 Apr 2003 11:37:12 +0200
Message-Id: <20030409093717.B115AC5877@atlas.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


In message <000d01c2fe74$83264520$1464a8c0@sjeng3> you wrote:
>
> Here's my 2nd question: is it a good idea that I modify ppcboot to
> include these network initialization functions just before booting my
> kernel image? Maybe this is not necessary but I really could not figure
> out why the "tftp" before loading kernel image made the difference
> on the network.

This is a somewhat philosophical question, and opinions differ.  IMHO
a  Linux  driver  usually should perform all required initializations
himself instead on relying on certain  things  to  be  done  by  some
firmware.


Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
"...one of the main causes of the fall of the Roman Empire was  that,
lacking  zero,  they had no way to indicate successful termination of
their C programs."                                     - Robert Firth

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
