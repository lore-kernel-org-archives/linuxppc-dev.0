Date: Tue, 10 Oct 2000 19:56:18 +0200 (METDST)
From: Gabriel Paubert <paubert@iram.es>
To: Dan Malek <dan@mvista.com>
cc: clark@esteem.com, linuxppc-embedded@lists.linuxppc.org
Subject: Re: Hanging in the Delay loop
In-Reply-To: <39E341BC.9D8FD69B@mvista.com>
Message-ID: <Pine.HPX.4.10.10010101952490.16113-100000@gra-ux1.iram.es>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Tue, 10 Oct 2000, Dan Malek wrote:

> Gabriel Paubert wrote:
>
> > Hmmm..., actually all processors have a TBEN pin (except the 601) and many
> > chipsets have a register which is designed to control this.
>
> Cool.  I didn't know most systems have external hardware to control
> this.  The embedded processors have software control in some
> internal registers.

I'd wish they would have done this for the desktop processors too, to
avoid chipset dependent, or even board dependent, code. The main use is
SMP timebase synchronization but it is important.

	Gabriel.


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
