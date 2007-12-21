Return-Path: <avorontsov@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [85.21.88.6])
	by ozlabs.org (Postfix) with ESMTP id 0EAD1DDE48
	for <linuxppc-dev@ozlabs.org>; Sat, 22 Dec 2007 08:02:48 +1100 (EST)
Date: Sat, 22 Dec 2007 00:04:45 +0300
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [PATCH 0/4] PowerPC: implement GPIO API
Message-ID: <20071221210445.GA5190@localhost.localdomain>
References: <20071221202824.GA4607@localhost.localdomain>
	<fa686aa40712211250l2645d34dr45c5be2bf1c9006d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf8
In-Reply-To: <fa686aa40712211250l2645d34dr45c5be2bf1c9006d@mail.gmail.com>
Cc: linuxppc-dev@ozlabs.org
Reply-To: avorontsov@ru.mvista.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, Dec 21, 2007 at 01:50:10PM -0700, Grant Likely wrote:
> On 12/21/07, Anton Vorontsov <avorontsov@ru.mvista.com> wrote:
> > Also, in the upcoming kernels, there will be GPIOLIB[1] addition to
> > the generic GPIO API, to support off-chip GPIO expanders (like MFDs
> > on I2C/LBC). But so far we support on-chip GPIOs only, with single
> > controller built-in.
> >
> > Changes since RFC:
> > - Implemented #gpio-cells handling;
> > - Per-bank spinlocks removed;
> > - Added a patch which implements GPIO API for CPM1;
> > - Few minor fixes.
> 
> Also need to add documentation to booting-without-of.txt.
> 
> In general this looks like a good direction, but I do not like the
> hard linking for QE and CPM gpios to the 'top level' gpio API.  I
> think I'd prefer this stuff to stay out of mainline until the gpiolib

Well, generally I'm okay to wait for gpiolib. Though...

> stuff gets merged (which should be soon IIRC).
                                     ^^^^ I doubt about that. :-)

I'm looking after gpiolib development (and, well, I also partipiated
in the discussion of earlier versions with former name "gpiodev") for
almost a _year_.

And they're still arguing about fluffy details of implementation.. :-/

As I've probably said once already: if there are plans to build single
kernel with QE+CPM1+CPM2 inside tomorrow -- then of course, I'd better
wait.

But if these plans are distant enough, I see no reason why we can't
enjoy of current API.

Thanks!

-- 
Anton Vorontsov
email: cbou@mail.ru
backup email: ya-cbou@yandex.ru
irc://irc.freenode.net/bd2
