Message-Id: <200002172015.VAA13366@denx.local.net>
To: Karl P lsson <KPA@infocom.dk>
Cc: linuxppc-embedded@lists.linuxppc.org,
        Frank Przybylski <Frank.Przybylski@vas-gmbh.de>
Subject: Re: Recommend a debugger
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Thu, 17 Feb 2000 10:45:09 +0100."
             <819E3E914E0AD11194DE00805F0D100B01088335@fbi.infocom.dk>
Date: Thu, 17 Feb 2000 21:15:51 +0100
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi Karl,

in message <819E3E914E0AD11194DE00805F0D100B01088335@fbi.infocom.dk> you write:
>
> What are people using for debugging code on the target, using the MPC823
> debug port?. What are the options and which debugger can you recommend?

What do you want to debug?

Application code? Then you should  do  fine  with  gdbserver  on  the
target and GDB / DDD on the host.

Kernel code? Are you looking for a BDM based debugger?  There  is  no
perfect solution available right now. There are some pretty good, but
expensive  professional  solutions  that  run  on the Linux host (for
instance, by Lauterbach and ETS), but they do not include any special
support for the Linux target - especially, they do  not  support  the
MMU  (so you will not be able to do kernel source code debugging once
the MMU is on, which is pretty early).

There are some cheaper solutions (MacCraigor) with similar problems.

Several people built their own debugger interfaces. The  latest  I've
seen  is  by  Frank  Przybylski  <Frank.Przybylski@vas-gmbh.de>,  see
http://www.vas-gmbh.de/software/mpcbdm/

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
"A little knowledge is a dangerous thing."                - Doug Gwyn

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
