Date: Thu, 6 Apr 2000 15:06:37 +0200 (METDST)
From: Gabriel Paubert <paubert@iram.es>
To: Tom Gall <gall@rochcivictheatre.org>
cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: Printing to the OF command line
In-Reply-To: <38EBE21E.FEA62A2C@rochcivictheatre.org>
Message-ID: <Pine.HPX.4.10.10004061457230.23926-100000@gra-ux1.iram.es>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Wed, 5 Apr 2000, Tom Gall wrote:

>
> Hi All,
>
>   This is an act of desperation on my part. But what the heck.
>
>   I'm trying to bring up a the 2.2.15pre14 kernel on an unsupported box.
> It's a 7043 43P 140 RS 6000. It's a labor of love.
>
>   Anyway, I've been having trouble even getting the kernel up any
> distance to even be able to puts to the screen. Something is dieing ...
> somewhere.
>
>   in arch/ppc/boot/of1275.c it would seem one should be able to perhaps
> open up some of device and print directly to the of command line without
> having to get into display adaptor issues. I would hope this would allow
> debugging in very difficult environments. (Which I'm in)

You don't even need to open it. Last time I successfully booted Linux on a
PreP machine with OF was early 96 (1.3.58 ?) so my memory is fuzzy. But
AFAIR I called the OF entry point with "interpret" command and executed
directly some string of Forth code.

>   Has anyone ever done this with this particular API? Is it even
> possible?

I think it is, and it's actually fairly simple. I could perhaps even find
it in my archives.

	Gabriel.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
