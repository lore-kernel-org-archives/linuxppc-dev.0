Message-ID: <39E36918.6E96FDF7@mvista.com>
Date: Tue, 10 Oct 2000 15:08:08 -0400
From: Dan Malek <dan@mvista.com>
MIME-Version: 1.0
To: Gabriel Paubert <paubert@iram.es>
CC: clark@esteem.com, linuxppc-embedded@lists.linuxppc.org
Subject: Re: Hanging in the Delay loop
References: <Pine.HPX.4.10.10010101952490.16113-100000@gra-ux1.iram.es>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Gabriel Paubert wrote:

> .... The main use is
> SMP timebase synchronization but it is important.

I'll just make one little suggestion, based upon lots of years
of multiprocessor development.  Find a software implementation that
doesn't require synchronized clocks local to each processor, and
then be grateful for the performance enhancement when you can have
synchronized clocks.

	-- Dan

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
