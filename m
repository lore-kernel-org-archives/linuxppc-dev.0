Message-ID: <3ADB6FFB.C40B3574@mvista.com>
Date: Mon, 16 Apr 2001 18:19:39 -0400
From: Dan Malek <dan@mvista.com>
MIME-Version: 1.0
To: Iain Sandoe <iain@sandoe.co.uk>
Cc: Gabriel Paubert <paubert@iram.es>,
	linuxppc-dev@lists.linuxppc.org, Samuel Rydh <samuel@ibrium.se>
Subject: Re: [PATCH] gettimeofday stability
References: <20010416160035.777CF2F0D3@apollo.valhalla.net>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Iain Sandoe wrote:
>
> > I still object strongly to anything touching the timebase, however.
>
> I'd prefer if it wasn't touched too...

As I recall, "touching" the TB simply means reading it and computing
elapsed ticks since the last read.  I don't remember anything changing
the value in the timebase registers (which isn't possible outside
of the kernel).

I regularly use the TB for user application event timing, and
haven't seen anything abnormal (other than the code I was testing :-).


	-- Dan

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
