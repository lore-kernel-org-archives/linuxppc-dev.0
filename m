Message-ID: <3E49278D.3020306@embeddededge.com>
Date: Tue, 11 Feb 2003 11:40:45 -0500
From: Dan Malek <dan@embeddededge.com>
MIME-Version: 1.0
To: Murray Jensen <Murray.Jensen@csiro.au>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: [PATCH] 8xx_io/uart.c
References: <30768.1044926029@ull>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Murray Jensen wrote:

> If you simply looked at the code you would see the problem we are talking
> about. What are you suggesting? That kgdb and xmon will _NEVER_ send a
> character with decimal value 10 via my_console_write()?

I've looked at it.  I know it well.  I wrote it.  I know how its used.
xmon and kgdb format their own strings/packets and expect read/write of
a simple uart fifo.

> http://lists.linuxppc.org/linuxppc-embedded/200205/msg00268.html

Well, ahhh, there isn't anything mentioned there about fixing bugs.  From
your description it's all about yet another scc uart configuration method.
I have lots of those on the shelf, all conflicting, that always seem to
be useful to the person/platform/application.  The easiest way to keep
everyone (un)happy is to leave things alone.  I used to apply those,
a new one every other week, and the only person happy about it was the
last one that had the patch applied.  :-)

You can pull the uart "bugfix" from the 2_4_devel tree now, if you wish.


	-- Dan


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
