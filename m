Date: Wed, 31 May 2000 16:32:10 -0400
From: Josh Huber <huberj@wpi.edu>
To: Linux/PowerPC Devel List <linuxppc-dev@lists.linuxppc.org>
Subject: Re: Lite-On ethernet controller
Message-ID: <20000531163210.E652@mclinux.com>
References: <20000531094520.B652@mclinux.com> <Pine.LNX.4.05.10005312154030.2148-100000@callisto.of.borg>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <Pine.LNX.4.05.10005312154030.2148-100000@callisto.of.borg>; from geert@linux-m68k.org on Wed, May 31, 2000 at 10:10:56PM +0200
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Wed, May 31, 2000 at 10:10:56PM +0200, Geert Uytterhoeven wrote:
> Later the card seemed to work fine with the updated tulip driver, as you
> probably remember.  However, I just got a problem with the updated driver
> (2.3.99-pre3) for the first time:
[snip]

After updating to the newer tulip driver in the devel kernels, my problems
with my real tulip card went away.  I've been having trouble getting two
other cards working however -- the lite-on card that I mentioned before, and
another tulip clone (Kingston).  The kingston card was much worse -- it
dropped ~30% of packets under light load, and completely locked up under
medium-heavy load.

> Note that Josh is using a similar box as me, a CHRP LongTrail. In fact all
> people with LongTrails seem to have problems with Tulip chips. So it might be a
> motherboard problem.
Yeah, which would be unfortunate... :(

Josh

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
