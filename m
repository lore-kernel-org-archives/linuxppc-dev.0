Date: Sun, 31 Oct 1999 20:28:37 -0600 (CST)
From: Takashi Oe <toe@unlserve.unl.edu>
To: "Kevin B. Hendricks" <khendricks@ivey.uwo.ca>
cc: linuxppc-dev@lists.linuxppc.org, Benjamin Herrenschmidt <bh40@calva.net>
Subject: Re: DMA macserial change seems to have messed up my pppd?
In-Reply-To: <v03110700b44273ab1522@[209.183.132.176]>
Message-ID: <Pine.LNX.3.96LJ1.1b7.991031201619.515A-100000@ofey.inetnebr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Sun, 31 Oct 1999, Kevin B. Hendricks wrote:

> Comparing Paul's rsync'd stable kernel from about a week or so before
> 2.2.13 was announced to a more recent version made late last week,
> something (the changes in macserial and use of DMA?) has completely made
> any ppp session unstable when used with any large, memory hungry
> applications which includes Netscape, the JDK, etc.
> 
> Prior to the DMA change my ppp connections were always completely stable.

Paul's linux-pmac-stable tree has changed quite a bit about ten days ago
when it was synced somewhat to Linus' and vger trees.  It's been somewhat
unstable on my machine as well since then.  I'm using the DMA support for
a month or so prior to that, and my machine was much more stable.

If you like, you can uncomment "#define SUPPORT_SERIAL_DMA" in macserial.c
to disable the DMA code and see if it changes anything.


Takashi Oe


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
