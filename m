Date: Tue, 10 Oct 2000 22:08:07 +0200 (METDST)
From: Gabriel Paubert <paubert@iram.es>
To: Dan Malek <dan@mvista.com>
cc: clark@esteem.com, linuxppc-embedded@lists.linuxppc.org
Subject: Re: Hanging in the Delay loop
In-Reply-To: <39E36918.6E96FDF7@mvista.com>
Message-ID: <Pine.HPX.4.10.10010102202210.16113-100000@gra-ux1.iram.es>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Tue, 10 Oct 2000, Dan Malek wrote:

> Gabriel Paubert wrote:
>
> > .... The main use is
> > SMP timebase synchronization but it is important.
>
> I'll just make one little suggestion, based upon lots of years
> of multiprocessor development.  Find a software implementation that
> doesn't require synchronized clocks local to each processor, and
> then be grateful for the performance enhancement when you can have
> synchronized clocks.

I can't figure how an implementation which works without synchronized
clocks will not allow to trivially synchronize the timebases.
Of course I mean an implementation with good precision.

	Regards,
	Gabriel.


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
