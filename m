To: Adrian Cox <adrian@humboldt.co.uk>
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: R128 Scaling.
References: <878z7nuamf.fsf@hades.nocrew.org>
	<20020416133220.782c956e.adrian@humboldt.co.uk>
From: Stefan Berndtsson <stefan@nocrew.org>
Date: 16 Apr 2002 14:53:10 +0200
In-Reply-To: <20020416133220.782c956e.adrian@humboldt.co.uk>
Message-ID: <87wuv7reix.fsf@hades.nocrew.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Adrian Cox <adrian@humboldt.co.uk> writes:

> I started looking at that a while ago, but didn't get very far. To get
> much further (and also to tackle the VGA out problems) I probably need
> the chip docs, but I haven't really pursued them. My one email asking to
> become an X developer was ignored, and I don't know of any other way to
> get the docs currently.
>
> The scaling patches I worked on had a problem with display flickering.
> They also needed a general mechanism to get the physical panel size.

I guess I never mentioned it was your patch I messed with. When switching
to 640x480, I get flickering if running 60Hz, but with 85 (which is what
fbset reports for me now), I see no such thing.

> > When running something in DGA (xmame for example), with XF4.1 and UseFBDev,
> > the resolution is changed by MAME, but it seems it still gets the fullsize
> > resolution passed to it, because it draws completely distorted graphics.
> > The area indicates that 1024x768 is passed as resolution even though the
> > display is set to 640x480 using scaling.
>
> I didn't get this one resolved at the time.

Too bad.. I hope it can be fixed :)

/Stefan

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
