Return-Path: <owner-linuxppc-dev@lists.linuxppc.org>
Date: Mon, 18 Mar 2002 14:33:26 -0900
From: Ethan Benson <erbenson@alaska.net>
To: linuxppc-dev@lists.linuxppc.org
Subject: Re: new bi_rec interface (was Re: [Ppcboot-users] Re: EV-64260 booting)
Message-ID: <20020318143326.B26309@plato.local.lan>
References: <20020312195125.GB25926@cpe-24-221-152-185.az.sprintbbd.net> <21274.1015997038@msa.cmst.csiro.au> <20020313155503.GB721@opus.bloom.county> <20020318152329.B324434@brule.borg.umn.edu>
Mime-Version: 1.0
In-Reply-To: <20020318152329.B324434@brule.borg.umn.edu>; from bergner@brule.borg.umn.edu on Mon, Mar 18, 2002 at 03:23:29PM -0600
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Mon, Mar 18, 2002 at 03:23:29PM -0600, Peter Bergner wrote:
>
> What happened to the idea (paulus' idea?) of creating some wrapper
> code (eg, zimage) that would build the bootinfo and pass it into
> the kernel, so yaboot doesn't need to do much other than pass in
> boot params?  This would force us to only boot zimages though
> (or whatever wrapper code we create).

from a logistical point of view this really seems to be the best
approach.  keeping all the details in a kernel wrapper of sorts gives
the kernel maintainers much more freedom to make changes in the
future, whereas if its kept in yaboot (rather $bootloader) you have to
deal with backword compatibility and endless luser error due to using
the wrong bootloader versions with wrong kernels.

of course if someone doesn't want to use the wrapper they can just use
the vmlinux and write thier own bootloader to handle all this stuff
and take on the effort of ensuring its up to date with what the kernel
wants.

--
Ethan Benson
http://www.alaska.net/~erbenson/

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
