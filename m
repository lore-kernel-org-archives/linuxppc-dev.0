Message-Id: <200104240553.HAA01467@piglet.grunz.lu>
Date: Tue, 24 Apr 2001 07:53:38 +0200 (CEST)
From: Michel Lanners <mlan@cpu.lu>
Reply-To: mlan@cpu.lu
Subject: Re: Rsync access through NAT?
To: jsmith@ash.penguinppc.org
Cc: linuxppc-dev@lists.linuxppc.org
In-Reply-To: <Pine.LNX.4.33.0104171133410.17972-100000@ash.penguinppc.org>
MIME-Version: 1.0
Content-Type: TEXT/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi Jeramy,

On  17 Apr, this message from jeramy b smith echoed through cyberspace:
>
> We had problems serving rsyncs with 2.4 also. Using 2.4 and an rsync built
> against 2.2 headers, we would get hung rsync processes that a stack trace
> revealed were hung in a newselect (Paulus already knows this bit).

Might this be the problem here:

http://slashdot.org/articles/01/04/24/0255224.shtml

I have ECN compiled in all my 2.4 kernels. They are building right now
without ECN.... We'll see.

<a compile & reboot later>

Yup, that seems to be the problem. rsync works again for me on
penguinppc. So I guess that some device close to penguinppc.org doesn't
support ECN.....

Well, no biggy, I'll just leave it disabled for now...

Cheers

Michel

-------------------------------------------------------------------------
Michel Lanners                 |  " Read Philosophy.  Study Art.
23, Rue Paul Henkes            |    Ask Questions.  Make Mistakes.
L-1710 Luxembourg              |
email   mlan@cpu.lu            |
http://www.cpu.lu/~mlan        |                     Learn Always. "


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
