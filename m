Date: Tue, 2 May 2000 13:22:21 +0200 (MET DST)
From: Albrecht Dress <adress@mpifr-bonn.mpg.de>
To: Bernhard Reiter <bernhard@intevation.de>
cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: Lombard hard freeze (still there)
In-Reply-To: <20000502104901.G14354@cheops.usf.Uni-Osnabrueck.DE>
Message-ID: <Pine.SOL.4.21.0005021314210.13937-100000@mpifr-bonn.mpg.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


> my problems with the hard freezes still continue.
> I have not come to any idea what is causing it.
> Several methods of trying to encircle the problem area failed.

Sorry, I am afraid I lost some messages of this thread.  Hope this is not
too outdated ;-)

I _have_ a Lombard running without problems.  So just some ideas which
might give you some more information.  Maybe you should try to work from
the first virtual (text) console (ctrl-opt-F1).  If the kernel panics
(which is does very likely) it will emit this information there, but you
will NEVER see it if you are in X, and it does not necessarily go into
/var/log/messages.

Did you check the serial port drivers?  I rember there were some problems
if you use the serial.c under LinuxPPC.  You do not need it, the right one
is macserial.c.  I could trigger panics on the Lombard and on my old 7300
by just typing "cat /dev/ttyS0 > /dev/null".

Hope this helps, Albrecht.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
