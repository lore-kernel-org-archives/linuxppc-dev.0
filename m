Date: Tue, 23 Mar 1999 21:52:52 -0700 (MST)
From: Jeff Rugen <jrugen@primenet.com>
To: Geert Uytterhoeven <Geert.Uytterhoeven@cs.kuleuven.ac.be>
cc: Linux/PPC Development <linuxppc-dev@lists.linuxppc.org>
Subject: Re: swapping shadow screen data
In-Reply-To: <Pine.LNX.4.03.9903221132420.564-100000@mercator.cs.kuleuven.ac.be>
Message-ID: <Pine.BSI.3.96.990323214725.2552A-100000@usr08.primenet.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Mon, 22 Mar 1999, Geert Uytterhoeven wrote:

> 
> Now all accesses to the shadow screen are done through scr_{read,write}w(), the
> tests for conswitchp in include/asm-ppc/vga.h should be removed. Can someone
> with both vgacon and fbcon in his/her kernel please verify that both vgacon and
> fbcon keep on working?
> 
> Thx!
> 

Ok, I used this as an excuse to go back to the vger stuff.  On a Motorola
PowerStack, with my clgenfb patch (but without any modifications to
fbcon-cfbXX.c), I compiled with vgacon in the kernel and fbcon as a module.
(I applied the patch Geert had included on the email I'm replying to as
well).  8-bit works fine.  I'm having problems with 16- and 32-bit modes,
but I have them with the 2.2.2 I was using before as well.  I think my
problems are in my clgenfb.c modifications though.

----------------------------------------------------------------------------
Jeff Rugen                      jrugen@primenet.com

..Had this been an actual emergency, we would have fled in terror, and you 
would not have been informed.


[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
