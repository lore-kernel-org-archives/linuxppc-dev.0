Message-ID: <3AF73161.26986237@mvista.com>
Date: Mon, 07 May 2001 19:36:01 -0400
From: Dan Malek <dan@mvista.com>
MIME-Version: 1.0
To: Eli Chen <eli@routefree.com>
Cc: Gabriel Paubert <paubert@iram.es>, brian.kuschak@skystream.com,
	linuxppc-embedded@lists.linuxppc.org
Subject: Re: dcache BUG()
References: <Pine.HPX.4.10.10105072359470.22253-100000@gra-ux1.iram.es> <3AF72CA8.52163E55@mvista.com> <03a001c0d74e$60022c70$4b00000a@foolio1>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Eli Chen wrote:

> >From the PPC manual:
> "Because the hardware doesn't compare reservation address when executing the
> stwcx.

F**K...that's what I was looking for.  What manual is that in?
Everything I have handy (older UISA books), state the granularity
is implementation dependent.  I couldn't find any 4xx manual that
stated the granularity of the reservation.  I thought 6xx/7xx at
least checked cache line granularity in addition to a single
reservation bit.

Gabriel is right................


	-- Dan

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
