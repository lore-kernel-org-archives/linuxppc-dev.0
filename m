Message-Id: <200011261928.eAQJS9G18463@denx.local.net>
To: roh <roh@hyte.de>
cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: linux 2.4.test on a mpc823 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Sun, 26 Nov 2000 16:42:14 +0100."
             <Pine.LNX.3.96.1001126163451.24412A-100000@killgates.hyte.de>
Date: Sun, 26 Nov 2000 20:28:09 +0100
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Dear Joachim,

in message <Pine.LNX.3.96.1001126163451.24412A-100000@killgates.hyte.de> you wrote:
>
> i'm reading this list for a while but cannor figure out
> if there's a ready-to-run package to get linux running
> on the mpc8xx-developer-board from motorola with an mpc823

Which board are you speaking of? The FADS?

> is there any linux-software to connect to this board?

It seems that for some reasons (search this list) the FADS boards are
not really attractive to the  people  who  did  most  of  the  kernel
development.

All the rest of the Linux software does not depend  on  the  specific
board.  You  should  be  able  to  use  any  of  the  existing  cross
development kits and native tool sets.

> one additional question: is the a 'bootloader' aviable for that board?
> my target-system is a ebbedded device with mpc823 8megs flash and 32megs
> ram. can i boot this directly? or must i write a bootloader myself?

Please see the PPCBoot project at http://ppcboot.sourceforge.net , or
doewnload the sources from ftp://ftp.denx.de/pub/ppcboot

There are a few people who have PPCBoot running on FADS systems.  But
I cannot really help you here, since we don't use FADS boards.

> thank you for answering me and sorry for my bad english

Wenn Du weitere Fragen hast, kannst Du  die  auch  gern  auf  Deutsch
stellen :-)

Hope it helps,

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
You don't have to stay up nights to succeed; you have to  stay  awake
days.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
