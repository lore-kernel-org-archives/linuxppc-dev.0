Subject: Re: Upgrade Blues 2.4.20 Ben H kernel
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Ira Weiny <iweiny@acm.org>
Cc: linuxppc-dev@lists.linuxppc.org
In-Reply-To: <20030307095717.1b1bece1.iweiny@acm.org>
References: <20030307095717.1b1bece1.iweiny@acm.org>
Content-Type: text/plain
Message-Id: <1047135968.12345.81.camel@zion.wanadoo.fr>
Mime-Version: 1.0
Date: 08 Mar 2003 16:06:08 +0100
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Fri, 2003-03-07 at 18:57, Ira Weiny wrote:
> Well I decided it was time to get up to date on my TiBook.
>
> So I went out and bought a copy of Yellow Dog and got apt-get installed and
> started hacking.  After some switching pain I got it up and running but found
> that I needed a newer kernel to get the networking stuff to work.
>
> no problem...  I rsync'ed Bens tree built and rebooted...
>
> There are 2 problems.
>
> 1) My Microdrive which I had hacked in does not work any more.  What is the
>    status of the ide-cs driver?  Anyone know?  It is different than when I got
>    it to work before and I am not sure where to begin again.

There are some problems with ide-cs currently. I'll try to work on it
this week-end.

> 2) m3mirror does not work?  This one really puzzles me.  lcd:0 turns off the
>    LCD screen but crt:1 does not turn on the outside monitor.  I rebooted into
>    Mac OS and the external port works.  The only thing I can think of is that I
>    did use the S-video port on Mac OS to show some pictures.  Is there
>    something in OF which Mac OS would set which would make the external port
>    not work with m3mirror?

Well... All it does is to enable the port by sending it the same signal
as the LCD. This works approx. well on the Pismo, but not with the tipb.

Somebody, I think, is working on proper mirroring based on setting up
the second CRTC.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
