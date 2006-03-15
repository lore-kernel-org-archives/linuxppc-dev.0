Return-Path: <mgreer@mvista.com>
Date: Wed, 15 Mar 2006 10:49:06 -0700
From: "Mark A. Greer" <mgreer@mvista.com>
To: Jon Loeliger <jdl@jdl.com>
Subject: Re: dtc: .quad asm directive generation
Message-ID: <20060315174906.GE13076@mag.az.mvista.com>
References: <20060313212105.GA11995@mag.az.mvista.com>
	<20060314033135.GA24168@localhost.localdomain>
	<20060314235254.GA6045@mag.az.mvista.com>
	<E1FJJXV-0005Zf-7r@jdl.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <E1FJJXV-0005Zf-7r@jdl.com>
Cc: linuxppc-dev <Linuxppc-dev@ozlabs.org>,
	David Gibson <david@gibson.dropbear.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, Mar 14, 2006 at 06:06:57PM -0600, Jon Loeliger wrote:
> So, like, the other day "Mark A. Greer" mumbled:
> > > 
> > > And finally, as of, well right about now, until October or so, I'm
> > > expecting to be unavailable, off travelling and things.  In the
> > > interim Jon Loeliger of Freescale has agreed to be dtc maintainer.
> > 
> > Jon, any comments?
> 
> For 9 months nothing.  Dave abdicates his DTC maintainer role to me.
> The very next day, all hell breaks loose!  Of _course_ I have comments!
> 
> Uh, I've been bitten by the difference between the binary and asm
> form of these outputs before as well.  Specifically where the reserve
> map included its own layout region as a reserve block.  IIRC, though,
> it was a physical versus virtual address problem that, though understood,
> we didn't really resolve.
> 
> I was eventually forced to move along, as that was not the battle I
> was looking for.  Our U-Boot eventually went to a straight binary
> form that was directly munged into a C array definition and side-stepped
> that issue.
> 
> As for the 64-bit-ness problem, I'm willing to accept donated 64-bit
> hardware that would allow me to test the problems you are seeing. :-)
> 
> I mean, any patches that drift my way will be considered. :-)

Heh!

Okay, right now the kernel/prom.c code is choking on the dt from the asm
file so I'll figure that out and then start poking into the dtc code and
see what I can figure out.

Mark
