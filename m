Date: Fri, 22 Jun 2001 14:37:14 +0200 (MEST)
From: Gabriel Paubert <paubert@iram.es>
To: Takashi Oe <toe@unlserve.unl.edu>
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: clock drift on PPC601
In-Reply-To: <20010621105656.6acca6e3.toe@unlserve.unl.edu>
Message-ID: <Pine.LNX.4.21.0106221418290.10296-100000@gra-lx1.iram.es>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Thu, 21 Jun 2001, Takashi Oe wrote:

> On Thu, 21 Jun 2001 14:57:39 +0200 (MEST), Gabriel Paubert wrote:
>
> > OTOH, I have a problem with my MVME2400/2600. Sometimes the calibrated
> > frequency is wrong by ~400ppm (about 1.5s/hour), most of the time it's
> > correct however. I can't understand how I get 400 microseconds off out of
> > a 1 second calibration period with interrupts masked. The value given by
> > the firmware never varies that much.
> >
> > I suspect that reading the CUDA RTC takes time. So using it for
> > calibration would not be very precise, no ?
>
> IIRC, pmac uses VIA for calibration not CUDA RTC.
>
> > > On a 7200 (PCI), RTCU incremented 493307 while CUDA RTC changed
>                                       ^^^^^^
> Make that 493533..  [I was reading off from a wrong line.  Sorry.]
>

Ok, that's much better. Actually very good for a computer.

> > I don't think we need any long long manipulation. You could already get HZ
> > times better precision by using the number of tb_ticks_per_second as a
> > reference and use a fractional PLL algorithm. In this case the resolution
> > would be about 1/78125000=0.128 ppm.
>
> Ok, I see.  Any code I can try/modify?  ;)

I'm going to try to write something this week-end.

	Regards,
	Gabriel.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
