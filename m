Message-ID: <37564972.5D564597@switchboard.ericsson.se>
Date: Thu, 03 Jun 1999 11:22:58 +0200
From: Magnus Damm <damm@kieraypc01.p.y.ki.era.ericsson.se>
MIME-Version: 1.0
To: Heinz Blaettner <heinz@bintec.de>
CC: "linuxppc-dev@lists.linuxppc.org" <linuxppc-dev@lists.linuxppc.org>
Subject: Re: MPC8xx: wrong zimage_start
References: <XFMail.990602185116.heinz@bintec.de>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>




> Hi Magnus

Hi there!

> Please give me a hint where to find the errata sheets ?.

You can find the 860 errata at motorolas website:

http://www.mot.com/netcomm/aesop/mpc8XX/860/860err.pdf

It contains a 860T specific part.

When I got my 860T didn't this errata contain any 860T specific
information at all.

> What problems about the 860T ?    Because we choose that device :-(

First of all, the B revision contains the serious bug that makes it
impossible to use the
fec and the cpm at the same time. great.

They don't mention the B revision in that errata. My FADS860T had that
chip when I got it.

I've got a B3 and that one still contains the CPU7 bug that makes
datacache corruption
when writing to sprs.

I've got a workaround from Dan that I've applied to my embedded-2.2.5
head.S.

The workaround works fine, now I'm stuck with some minor fec.c problem.

Hope this helps! /

Magnus

[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
