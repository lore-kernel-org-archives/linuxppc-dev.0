Message-Id: <5.1.0.14.2.20020828110521.0230f788@falcon.si.com>
Date: Wed, 28 Aug 2002 11:08:31 -0400
To: <linuxppc-dev@lists.linuxppc.org>
From: Jerry Van Baren <vanbaren_gerald@si.com>
Subject: RE: Cross compile helper patch
In-Reply-To: <NCBBIINEHIPFGJPLBEIFEEFCDLAA.acurtis@onz.com>
References: <1030536069.28699.14.camel@spawn>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


At 07:33 AM 8/28/2002 -0700, Allen Curtis wrote:

> > This is what I do when cross compiling
> >
> > make ARCH=ppc CROSS_COMPILE=powerpc-linux-
>
>Duh, that was an easy solution! Thanks, why didn't I think of that?
>

...and if you are REALLY lazy (like me) and only use one cross development
toolset, you can define and export CROSS_COMPILE and ARCH (I haven't needed
ARCH) in your .bashrc (or equiv.) and "make" will Do The Right Thing (TM).

gvb


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
