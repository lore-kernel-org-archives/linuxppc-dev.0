Message-ID: <20000502191317.779.qmail@web1704.mail.yahoo.com>
Date: Tue, 2 May 2000 12:13:17 -0700 (PDT)
From: Gabriel Ricard <g_ricard@yahoo.com>
Subject: Re: Lombard hard freeze (still there)
To: linuxppc-dev@lists.linuxppc.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


I am wondering if any of the developers who do kernel
related work on LinuxPPC have any suggestions for us
on how to deal with this. If I knew how to do the
debugging work and trace the problem to its root I
would.

--- Bernhard Reiter <bernhard@intevation.de> wrote:
> On Tue, May 02, 2000 at 01:22:21PM +0200, Albrecht
> Dress wrote:
> > > my problems with the hard freezes still
> continue.
> > > I have not come to any idea what is causing it.
> > > Several methods of trying to encircle the
> problem area failed.
> >
> > Sorry, I am afraid I lost some messages of this
> thread.  Hope this is not
> > too outdated ;-)
>
> You can look it up in the webarchive.
>
http://lists.linuxppc.org/listarcs/linuxppc-dev/200004/threads.html
>
>
> > I _have_ a Lombard running without problems.  So
> just some ideas which
> > might give you some more information.  Maybe you
> should try to work from
> > the first virtual (text) console (ctrl-opt-F1).
> If the kernel panics
> > (which is does very likely) it will emit this
> information there, but you
> > will NEVER see it if you are in X, and it does not
> necessarily go into
> > /var/log/messages.
>
> The hard freeze's low temperature prohibits all
> output.
> Never got any error message.
>
> > Did you check the serial port drivers?  I rember
> there were some problems
> > if you use the serial.c under LinuxPPC.  You do
> not need it, the right one
> > is macserial.c.  I could trigger panics on the
> Lombard and on my old 7300
> > by just typing "cat /dev/ttyS0 > /dev/null".
>
> Yes I check the serial driver, built a kernel
> without usb and
> serial support at all. But the symptoms are still
> there.
>
> I have 192 MB of RAM though and a 10 Gb drive ,
> these are the only
> differences which I think my machine might have to
> other lombards.
>
> 	Bernhard
>
> --
> Professional Service around Free Software
>     (intevation.net)
> The FreeGIS Project				            (freegis.org)
> Association for a Free Informational Infrastructure
>           (ffii.org)
>

> ATTACHMENT part 2 application/pgp-signature


=====
Gabriel Ricard
g_ricard@yahoo.com

Send instant messages & get email alerts with Yahoo! Messenger.
http://im.yahoo.com/

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
