Message-ID: <3949DDBD.331E255F@wanadoo.fr>
Date: Fri, 16 Jun 2000 09:56:45 +0200
From: Martin Costabel <costabel@wanadoo.fr>
MIME-Version: 1.0
To: Geert Uytterhoeven <geert@linux-m68k.org>
CC: Linux/PPC Development <linuxppc-dev@lists.linuxppc.org>
Subject: Re: Interrupt hick ups
References: <Pine.LNX.4.05.10006142236120.5007-100000@callisto.of.borg>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Geert Uytterhoeven wrote:
>
> On Tue, 13 Jun 2000, Geert Uytterhoeven wrote:
> > Since a few kernel versions (late 2.3.x), I see interrupt hick ups when doing
> > disk access on my Sym53c875. I.e. when I'm typing something and the disk
> > shows a lot of activity, keystrokes and mouse moves happen in burst with some
> > delay (ca. 2 seconds).
> >
> > Anyone seeing a similar thing? This is on a CHRP LongTrail.

Do you still see this in -ac16 or later? I had this, too, and from
linux-kernel I understand that everyody had it, but it's gone now.

What is gone too, unfortunately, is the phenomenal IDE speed
improvement. In late 2.3.99/early 2.4.0-test1, I had a "hdparm
-t"-measured throughput more than 3 times as high (almost 6MB/sec,
sometimes more) as with 2.2.x (1.90MB/sec). It diminished in -ac15
(3.25MB/sec), and in -ac16 it is almost back down (2.30MB/sec) to the
2.2.x values.

--
Martin

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
