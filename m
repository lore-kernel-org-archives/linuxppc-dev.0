Date: Wed, 12 Mar 2003 23:50:40 -0800
From: Ira Weiny <iweiny@acm.org>
Subject: Re: Upgrade Blues 2.4.20 Ben H kernel
In-reply-to: <20030310164855.GC11462@haar.ae.gatech.edu>
To: Manuj Dhingra <manuj_dhingra@ae.gatech.edu>
Cc: linuxppc <linuxppc-dev@lists.linuxppc.org>
Message-id: <20030312235040.4ca0d0ce.iweiny@acm.org>
MIME-version: 1.0
Content-type: text/plain; charset=US-ASCII
References: <20030310164855.GC11462@haar.ae.gatech.edu>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Mon, 10 Mar 2003 11:48:55 -0500
Manuj Dhingra <manuj_dhingra@ae.gatech.edu> wrote:

>
> >
> > Well... All it does is to enable the port by sending it the same signal
> > as the LCD. This works approx. well on the Pismo, but not with the tipb.
> >
> > Somebody, I think, is working on proper mirroring based on setting up
> > the second CRTC.
> >

Well with your 2.4.15-pre7-ben0 the external monitor was working with my
TiBook.  Worked quite well.  I did not set the external monitor the same as the
LCD 'cause the refresh rates were different but I could turn on the external
and the LCD off and use the external quite well.  So I can tell you that
worked.

>
> Well I am, but I have not seen this one before. With Ben's m3mirror and
> corresponding ioctls, crt:1 did turn on the external display, it was just
> not stable.
> Could you please boot with external monitor plugged in at power on and
> pass video=aty128fb:crt:1,lcd:1 as additional boot parameters?

I did as you ask.

When the machine booted I got this on the external monitor:

...ok
copying OF device tree...done
Initializing fake screen: ATY,RageM3p12A
Calling quiesce
returning 0x01400000 from prom_init

I saw a message concering quiesce before.  Maybe this message was from you.
Sorry I did not keep it.

Once I started X The screen displays garbage but seems to change when I bring
up windows or change desktops.  So something is out there.  Looks like the
frame buffer is out of order or something?  I don't know I am just guessing.

Thanks,
Ira
iweiny@acm.org


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
