Message-Id: <200104171531.RAA00992@piglet.grunz.lu>
Date: Tue, 17 Apr 2001 17:31:12 +0200 (CEST)
From: Michel Lanners <mlan@cpu.lu>
Reply-To: mlan@cpu.lu
Subject: Re: Rsync access through NAT?
To: jsmith@ash.penguinppc.org
Cc: linuxppc-dev@lists.linuxppc.org
In-Reply-To: <Pine.LNX.4.33.0104170144460.14396-100000@ash.penguinppc.org>
MIME-Version: 1.0
Content-Type: TEXT/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi again,

To the list: for some time now, I've had problems accessing
penguinppc.org from my PPC machines (I've noticed it with rsync... for
www I use a proxy on i386).

Turns out the problem only occurs with 2.4 kernels:

[mlan@piglet ~]$ uname -a
Linux piglet 2.4.3-pre3 #4 Thu Apr 12 01:47:59 CEST 2001 ppc unknown
(benh's tree)

and 2.4.4-pre1 from benh on the TiBook.

Anyone else seen this? Note, with a 2.2 kernel, all is OK. I've not had
a chance to test a 2.4 kernel on i386 to see whether it's the same over
there.

I hope it doesn't matter, but I'm accessing the net through a NAT router
(which is configured OK, thanks for asking ;-)

Michel

-------------------------------------------------------------------------
Michel Lanners                 |  " Read Philosophy.  Study Art.
23, Rue Paul Henkes            |    Ask Questions.  Make Mistakes.
L-1710 Luxembourg              |
email   mlan@cpu.lu            |
http://www.cpu.lu/~mlan        |                     Learn Always. "


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
