Date: Sat, 30 Sep 2000 16:51:02 +0300 (EEST)
From: Kostas Gewrgiou <gewrgiou@imbc.gr>
To: Michael Schmitz <schmitz@opal.biophys.uni-duesseldorf.de>
cc: Michel Dänzer <daenzerm@student.ethz.ch>, R Shapiro <rshapiro@bbn.com>,
        linuxppc-dev@lists.linuxppc.org
Subject: Re: beige g3 rage II xf4.0.1 and miBoot
In-Reply-To: <Pine.LNX.4.10.10009292141300.7428-100000@opal.biophys.uni-duesseldorf.de>
Message-ID: <Pine.LNX.4.21.0009301631060.2538-100000@idd-01.imbc.gr>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Fri, 29 Sep 2000, Michael Schmitz wrote:

> > > Because it happens by the framebuffer driver (kernel space).
> >
> > And it doesn't with x86? :)
>
> Did you try with a framebuffer (vesafb for instance) on x86, and the
> UseFBDev option? Did anyone ever try?

Yeap i tried it with aty128fb (long time ago), without busID set everything
works you don't get anything in the screen, no panics/locks as in the ppc
side.

 Kostas


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
