Date: Sun, 6 Aug 2000 01:01:10 -0500 (CDT)
From: Takashi Oe <toe@unlserve.unl.edu>
To: David Edelsohn <dje@watson.ibm.com>
cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: a GCC question 
In-Reply-To: <200008060457.AAA28180@mal-ach.watson.ibm.com>
Message-ID: <Pine.LNX.3.96LJ1.1b7.1000806003715.14804A-100000@ofey.earthlink.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi,

On Sun, 6 Aug 2000, David Edelsohn wrote:

> >>>>> Takashi Oe writes:
>
> >> Even if the default is to do nothing, one always should provide a
> >> default action or just break so that the density / coverage of the switch
> >> statement cases is apparent.
>
> Takashi> I don't know what the density is, but, if having a default action for
> Takashi> nothing is always prefered, I'll fix it (or rather I'll ask Ben to fix
> Takashi> it.)  Is it in gcc documentation or C standard somewhere?
>
> 	It's not in the documentation or in the standard.  It is good, but
> not a requirements.  It helps document that the programmer knows what is
> expected and sometimes helps the compiler generate better code by knowing
> what cases need be considered.

Thank you for the explanation.  Actually, I used to put a default action
always with a switch statement because that's how I was taught when I
first learned to code in C, well, until I came across a code in Linux
kernel which had a switch statement without a default action.  At first I
was skeptical, but I realized I can save two lines of typing that way when
there is nothing to do for default, and I got accustomed to code similarly
rather quickly.  But, if it helps the compiler, I can type the extra two
lines as I used to.  No problem.

By the way, has anyone noticed compiling arch/ppc/mm/init.c takes very
long time?  On my machine, it takes as long as about two minutes to just
compile it, while compiling other files are almost instantaneous.  Well,
it's one of the biggest C files, but, still, I wonder if we can organize
the code a bit to help the compiler somehow.  Perhaps, my machine is too
slow?


Takashi Oe


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
