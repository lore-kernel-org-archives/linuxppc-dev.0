Date: Mon, 10 Mar 2003 11:48:55 -0500
From: Manuj Dhingra <manuj_dhingra@ae.gatech.edu>
To: Nathan Ingersoll <ningerso@ruralcenter.org>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	linuxppc-dev@lists.linuxppc.org
Subject: Re: Upgrade Blues 2.4.20 Ben H kernel
Message-ID: <20030310164855.GC11462@haar.ae.gatech.edu>
Mime-Version: 1.0
Content-Type: text/plain; format=flowed; charset=ISO-8859-1
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


> From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> Subject: Re: Upgrade Blues 2.4.20 Ben H kernel
>
> On Fri, 2003-03-07 at 18:57, Ira Weiny wrote:
> > Well I decided it was time to get up to date on my TiBook.
> >
> > 2) m3mirror does not work?  This one really puzzles me.  lcd:0 turns
> off the
> >    LCD screen but crt:1 does not turn on the outside monitor.  I
> rebooted into
> >    Mac OS and the external port works.  The only thing I can think of
> is that I
> >    did use the S-video port on Mac OS to show some pictures.  Is there
> >    something in OF which Mac OS would set which would make the external
> port
> >    not work with m3mirror?
>
> Well... All it does is to enable the port by sending it the same signal
> as the LCD. This works approx. well on the Pismo, but not with the tipb.
>
> Somebody, I think, is working on proper mirroring based on setting up
> the second CRTC.
>

Well I am, but I have not seen this one before. With Ben's m3mirror and
corresponding ioctls, crt:1 did turn on the external display, it was just
not stable.
Could you please boot with external monitor plugged in at power on and
pass video=aty128fb:crt:1,lcd:1 as additional boot parameters?

cheers,
manuj

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
