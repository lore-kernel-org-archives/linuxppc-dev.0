Message-ID: <39D4E8FC.7ECDDCAD@student.ethz.ch>
Date: Fri, 29 Sep 2000 21:09:48 +0200
From: Michel Dänzer <daenzerm@student.ethz.ch>
MIME-Version: 1.0
To: Michael Schmitz <schmitz@opal.biophys.uni-duesseldorf.de>
CC: Kostas Gewrgiou <gewrgiou@imbc.gr>, R Shapiro <rshapiro@bbn.com>,
        linuxppc-dev@lists.linuxppc.org
Subject: Re: beige g3 rage II xf4.0.1 and miBoot
References: <Pine.LNX.4.10.10009291932370.7428-100000@opal.biophys.uni-duesseldorf.de>
Content-Type: text/plain; charset=iso-8859-1
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Michael Schmitz wrote:
>
> > PS> Any ideas why writing to a disabled pci device in ppc crashes
> > the machine but not the x86 ones ? Is this something that can be fixed
> > in the kernel or an arch thing ?
>
> Because it happens by the framebuffer driver (kernel space).

And it doesn't with x86? :)


Michel


--
Earthling Michel Dänzer (MrCooper)  \  CS student and free software enthusiast
Debian GNU/Linux (powerpc,i386) user \   member of XFree86 and The DRI Project

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
