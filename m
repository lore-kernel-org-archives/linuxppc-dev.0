Message-ID: <XFMail.20011030123800.pochini@shiny.it>
Content-Type: text/plain; charset=us-ascii
MIME-Version: 1.0
In-Reply-To: <15326.8355.242681.874353@cargo.ozlabs.ibm.com>
Date: Tue, 30 Oct 2001 12:38:00 +0100 (CET)
From: Giuliano Pochini <pochini@shiny.it>
To: Paul Mackerras <paulus@samba.org>
Subject: RE: floating-point under ppc/linux
Cc: linuxppc-dev@lists.linuxppc.org
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


> In other words, if a program blocks SIGFPE, does something that
> generates a floating-point exception, then clears the exception status
> in FPSCR, then unblocks SIGFPE, should it get a SIGFPE signal
> delivered to it at that point ?

AFAIK posix says that blocked signals have to be queued (at least one
of them) and that signals have to be delivered when those signals are
unblocked. I don't know if it makes sense about hardware signals, but
that's the spec.

I agree with the signal modes you proposed, but you should also
allow the user to set the 11 mode in some way. Debuggers could need that.


Bye.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
