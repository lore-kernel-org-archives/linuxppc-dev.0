Date: Wed, 17 May 2000 12:54:22 +0200 (CEST)
From: Michael Schmitz <schmitz@opal.biophys.uni-duesseldorf.de>
To: Albrecht Dreﬂ <ad@mpifr-bonn.mpg.de>
cc: Tim Wojtulewicz <Tim.Wojtulewicz@NAU.EDU>, linuxppc-dev@lists.linuxppc.org,
        debian-powerpc@lists.debian.org
Subject: Re: Pismo status
In-Reply-To: <39226066.BF822A70@mpifr-bonn.mpg.de>
Message-ID: <Pine.LNX.4.10.10005171253140.16549-100000@opal.biophys.uni-duesseldorf.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


> Tim Wojtulewicz wrote:
> > No it's definitely supposed to have a fan.  It comes on in MacOS.
> > The problem is that the PMU is not fully supported yet, so it doesn't
> > understand that the processor is too hot.  I'm trying to find
>                       ^^^^^^^^^^^^^^^^^^^^
> Does this mean that I can damage the machine if I just run a high-load
> program?!?

I strongly doubt that. The PMU should handle this autonomously, regardless
of Linux support for the PMU.

	Michael


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
