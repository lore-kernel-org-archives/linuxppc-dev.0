Date: Tue, 17 Apr 2001 11:36:39 -0500 (CDT)
From: jeramy b smith <jsmith@ash.penguinppc.org>
To: Michel Lanners <mlan@cpu.lu>
Cc: <linuxppc-dev@lists.linuxppc.org>
Subject: Re: Rsync access through NAT?
In-Reply-To: <200104171531.RAA00992@piglet.grunz.lu>
Message-ID: <Pine.LNX.4.33.0104171133410.17972-100000@ash.penguinppc.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


We had problems serving rsyncs with 2.4 also. Using 2.4 and an rsync built
against 2.2 headers, we would get hung rsync processes that a stack trace
revealed were hung in a newselect (Paulus already knows this bit).

If rsync was built against 2.4 headers it would hang on the first hung
process and then refuse connections.

-jeramy b smith




On Tue, 17 Apr 2001, Michel Lanners wrote:

> Hi again,
>
> To the list: for some time now, I've had problems accessing
> penguinppc.org from my PPC machines (I've noticed it with rsync... for
> www I use a proxy on i386).
>
> Turns out the problem only occurs with 2.4 kernels:
>
> [mlan@piglet ~]$ uname -a
> Linux piglet 2.4.3-pre3 #4 Thu Apr 12 01:47:59 CEST 2001 ppc unknown
> (benh's tree)
>
> and 2.4.4-pre1 from benh on the TiBook.
>
> Anyone else seen this? Note, with a 2.2 kernel, all is OK. I've not had
> a chance to test a 2.4 kernel on i386 to see whether it's the same over
> there.
>
> I hope it doesn't matter, but I'm accessing the net through a NAT router
> (which is configured OK, thanks for asking ;-)
>
> Michel
>
> -------------------------------------------------------------------------
> Michel Lanners                 |  " Read Philosophy.  Study Art.
> 23, Rue Paul Henkes            |    Ask Questions.  Make Mistakes.
> L-1710 Luxembourg              |
> email   mlan@cpu.lu            |
> http://www.cpu.lu/~mlan        |                     Learn Always. "
>


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
