From: Der Herr Hofrat <der.herr@hofr.at>
Message-Id: <200407240629.i6O6TuX25611@hofr.at>
Subject: Re: Linux is not reliable enough?
In-Reply-To: <wn5pt6mw1jc.fsf@linhd-2.ca.nortel.com> from Linh Dang at "Jul 23,
 2004 11:02:15 pm"
To: Linh Dang <linh@home.earth>
Date: Sat, 24 Jul 2004 08:29:56 +0200 (CEST)
Cc: Embedded Linux PPC list <linuxppc-embedded@lists.linuxppc.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


>
> Well, X server doesn't run in the same vm space as the
> kernel. however, on my PC, X is the thing that would most likely to
> put the system into an unusable state (frozen keyboard, mouse and
> screen).

in prinzipal that is the way it should be but this is not quite true
as X utilizes user-space (SUID-ROOT) drivers quite a lot - so even though
X is in its on VM it is fiddling with low level resources that are normally
under kernel control (i.e. sti/cli). So this is actually the
same problem in Linux as you noted for QNX.

hofrat

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
