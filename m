Date: Fri, 29 Sep 2000 21:44:48 +0200 (CEST)
From: Michael Schmitz <schmitz@opal.biophys.uni-duesseldorf.de>
To: Michel Dänzer <daenzerm@student.ethz.ch>
cc: Kostas Gewrgiou <gewrgiou@imbc.gr>, R Shapiro <rshapiro@bbn.com>,
        linuxppc-dev@lists.linuxppc.org
Subject: Re: beige g3 rage II xf4.0.1 and miBoot
In-Reply-To: <39D4E8FC.7ECDDCAD@student.ethz.ch>
Message-ID: <Pine.LNX.4.10.10009292141300.7428-100000@opal.biophys.uni-duesseldorf.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


> > Because it happens by the framebuffer driver (kernel space).
>
> And it doesn't with x86? :)

Did you try with a framebuffer (vesafb for instance) on x86, and the
UseFBDev option? Did anyone ever try?

Hint: it'll happen in the setcolreg framebuffer routine. If it just won't
happen on a comparable setup on x86, I'd suspect x86 fbdev drivers access
these card functions via the IO region whereas PPC uses the MMIO region
(dirty-aliased to VRAM).

	Michael


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
