Message-ID: <39A2F6C7.F2743BF7@student.ethz.ch>
Date: Tue, 22 Aug 2000 23:55:19 +0200
From: Michel Dänzer <daenzerm@student.ethz.ch>
MIME-Version: 1.0
To: mlan@cpu.lu
CC: geert@linux-m68k.org, linuxppc-dev@lists.linuxppc.org, dmj+@andrew.cmu.edu
Subject: Re: Control fb problem on 8500
References: <200008222115.XAA00745@piglet.grunz.lu>
Content-Type: text/plain; charset=iso-8859-1
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Michel Lanners wrote:

> supposing someone actually finds out how control's hardware cursor works,
> and supposing someone would actually take the time to implement this,
> wouldn't we need to provide a XFree driver as well? I guess plain fbdevhw
> doesn't support hw cursor...

Don't think that there are fbdev ioctls to control it either.


> In that event, would it be possible to address the above-mentioned flaw
> in XFree in that particular driver, or is the problem more geneic (i.e.
> littered throughout the source tree)?

No, the driver can handle it very easily by setting pScrn->displayWidth to the
correct value.

The problem with the fbdev driver is that it should know that value before it
possibly can (before the mode is initialized).


Michel


--
Earthling Michel Dänzer (MrCooper)  \  CS student and free software enthusiast
Debian GNU/Linux (powerpc,i386) user \   member of XFree86 and The DRI Project

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
