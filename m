Date: Wed, 17 May 2000 14:08:36 +0200
From: Sven LUTHER <luther@debian.org>
To: Michael Schmitz <schmitz@opal.biophys.uni-duesseldorf.de>
Cc: Albrecht Dreﬂ <ad@mpifr-bonn.mpg.de>,
        Tim Wojtulewicz <Tim.Wojtulewicz@nau.edu>,
        linuxppc-dev@lists.linuxppc.org, debian-powerpc@lists.debian.org
Subject: Re: Pismo status
Message-ID: <20000517140836.A12638@lambda.u-strasbg.fr>
Reply-To: luther@dpt-info.u-strasbg.fr
References: <39226066.BF822A70@mpifr-bonn.mpg.de> <Pine.LNX.4.10.10005171253140.16549-100000@opal.biophys.uni-duesseldorf.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <Pine.LNX.4.10.10005171253140.16549-100000@opal.biophys.uni-duesseldorf.de>; from schmitz@opal.biophys.uni-duesseldorf.de on Wed, May 17, 2000 at 12:54:22PM +0200
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Wed, May 17, 2000 at 12:54:22PM +0200, Michael Schmitz wrote:
> > Tim Wojtulewicz wrote:
> > > No it's definitely supposed to have a fan.  It comes on in MacOS.
> > > The problem is that the PMU is not fully supported yet, so it doesn't
> > > understand that the processor is too hot.  I'm trying to find
> >                       ^^^^^^^^^^^^^^^^^^^^
> > Does this mean that I can damage the machine if I just run a high-load
> > program?!?
>
> I strongly doubt that. The PMU should handle this autonomously, regardless
> of Linux support for the PMU.

Also, i think the ppc cpu will halt itself when becoming too hot, and not let
itself burn. At elast it was so since the earlier 680x0 cpus.

Friendly,

Sven LUTHER

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
