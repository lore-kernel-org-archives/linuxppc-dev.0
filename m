Date: Sat, 18 Mar 2000 14:32:59 -0500
From: Daniel Jacobowitz <drow@false.org>
To: Michel Lanners <mlan@cpu.lu>
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: controlfb: please test!
Message-ID: <20000318143259.A11235@drow.res.cmu.edu>
References: <200003180903.KAA00291@piglet.grunz.lu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <200003180903.KAA00291@piglet.grunz.lu>; from mlan@cpu.lu on Sat, Mar 18, 2000 at 10:03:05AM +0100
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Well, first of all, there are two different 'current' controlfb's.  One
of them is in the PPC 2.2 tree and the other in the 2.3 tree (both
bitkeeper), I believe.  Did you try both of those?  I'm pretty sure I
fixed this quite thoroughly in one or the other.

I admit (ashamedly) to not remembering which.

Actually, on closer look, I thought that the 2.3 code was correct.
Could you compare to Andrew's observations in the comment above the
code?  Is he wrong?  I certainly can't see how his comment would be
unless there is a memory scheme he was not detecting, and I do not
think there is.

I have a bunch of other patches to merge for controlfb anyway, so now
is a good time to straighten this out... with luck and speed we can get
a fix into 2.3.99preX.

On Sat, Mar 18, 2000 at 10:03:05AM +0100, Michel Lanners wrote:
> Hi list,
>
> You may remeber my problems (and the many other problems reported over
> the years ;-) with controlfb's detection of the amount of VRAM
> installed.
>
> Well, it seems control has some bugs, which makes detection less easy,
> and until now, only one of two possible schemes for the memory layout
> was correctly detected.
>
> Well, I think it's time to clean this mess up, so I want _all_
> developers with any machine that has the control hardware
> (PowerMacs 7300, 7500, 7600, 8500, 8600, clones?) to try the following
> patch on a 2.3 kernel, and report the results to me.
>
> Mine look like this, with 2 MB in bank2:
> ....
> control: mem at 0x000000: no
> control: mem at 0x200000: no
> control: mem at 0x400000: no
> control: mem at 0x600000: yes
> controlfb: Memory bank 1 absent, bank 2 present, total VRAM 2MB
> ....
>
> Please include yur VRAM configuration, and if you have the time, please
> try all possible combinations (2MB in either bank1 or bank2, and 4MB).


Dan

/--------------------------------\  /--------------------------------\
|       Daniel Jacobowitz        |__|        SCS Class of 2002       |
|   Debian GNU/Linux Developer    __    Carnegie Mellon University   |
|         dan@debian.org         |  |       dmj+@andrew.cmu.edu      |
\--------------------------------/  \--------------------------------/

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
