Message-ID: <39D28B5B.838C4FC8@student.ethz.ch>
Date: Thu, 28 Sep 2000 02:05:47 +0200
From: Michel Dänzer <daenzerm@student.ethz.ch>
MIME-Version: 1.0
To: Michael Schmitz <schmitz@zirkon.biophys.uni-duesseldorf.de>
CC: R Shapiro <rshapiro@bbn.com>,
        Michael Schmitz <schmitz@opal.biophys.uni-duesseldorf.de>,
        linuxppc-dev@lists.linuxppc.org
Subject: Re: xf 4.0.1 + ati driver with rage II/rage pro
References: <Pine.LNX.4.10.10009272059060.9291-100000@zirkon.biophys.uni-duesseldorf.de>
Content-Type: text/plain; charset=iso-8859-1
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Michael Schmitz wrote:

> > Hmm, if change the driver to "ati", am I also supposed the change the
> > device node Option to "ati", ie 'Option "ati" "/dev/fb0"'?  I never
> > tried that.

Certainly not, "fbdev" if anything.


> Nope, the syntax should be OK. Question is does the ati driver parse that
> option if fb_open_pci is used.

I just rsynced Ani's tree, and the ati driver doesn't. Ani, why not?


Michel


--
Earthling Michel Dänzer (MrCooper)  \  CS student and free software enthusiast
Debian GNU/Linux (powerpc,i386) user \   member of XFree86 and The DRI Project

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
