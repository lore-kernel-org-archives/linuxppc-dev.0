Message-ID: <3D80D1F2.6FBAEFE6@esteem.com>
Date: Thu, 12 Sep 2002 10:42:10 -0700
From: Conn Clark <clark@esteem.com>
MIME-Version: 1.0
To: Alban Wood <awood@bloodwolf.org>
Cc: May Ling List <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: mpc8xx fpu emu
References: <Pine.LNX.4.44.0209121107090.7728-100000@manoir.bloodwolf.org>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Alban Wood wrote:

<snip>

> I was unaware of this. I guess I would have realized this at some point
> but would have lost a lot of time.
>
> Are there specific known cases or instructions for which the emulator
> doesn't behave correctly?
>

	Unfortunatly I haven't tried using the fpu emulation, I'm just
relaying to you what I've been told when I pursued it hoping to save ram.
After finding out it would only shave about 4K off of glibc I abandoned
the quest. I determined it was just not worth the hassel for such small
gains and applying my efforts elsewhere would yeild greater savings.

	I don't know of anyone who has tried it lately, so the bugs may
no longer exist. Wolfgang Denk (who's opinion I hold with high regard)
has said that he could get it to fail with the "ls -l" command as I
recall.
<snip>

>
> Yes it does. Thank you!
>
> Alban

	Exactly why do you want to use fpu emulation?



Hope I'm helping

	Conn

--

*****************************************************************
  If you live at home long enough, your parents will move out.
 (Warning they may try to sell their house out from under you.)
*****************************************************************

Conn Clark
Engineering Stooge				clark@esteem.com
Electronic Systems Technology Inc.		www.esteem.com


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
