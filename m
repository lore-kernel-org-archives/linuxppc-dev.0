Return-Path: <dgibson@ozlabs.org>
Date: Sat, 20 Oct 2007 17:10:43 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: embedded a default dtb in the kernel (was merge dtc)
Message-ID: <20071020071043.GB26642@localhost.localdomain>
References: <556445368AFA1C438794ABDA8901891C075945FD@USA0300MS03.na.xerox.net>
	<fa686aa40710191209u883b3d0r954e7b3d6d1b8d12@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <fa686aa40710191209u883b3d0r954e7b3d6d1b8d12@mail.gmail.com>
Cc: linuxppc-dev <Linuxppc-dev@ozlabs.org>, "Leisner,
	Martin" <Martin.Leisner@xerox.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, Oct 19, 2007 at 01:09:39PM -0600, Grant Likely wrote:
> On 10/19/07, Leisner, Martin <Martin.Leisner@xerox.com> wrote:
> > Is there a way to embed a default dtb into the kernel?
> > When I build a kernel, I want to embed a dtb into it --
> > so I don't have to deal with the headaches of finding the
> > right file to match the right board (its always easier to
> > deal with 1 file than 2).
> >
> > If there is, it makes sense to put dtc into the tree.
> > If there's not, there should be a way to embed dtb's; and put
> > dtc and dts's into the tree.
> > If there can't be (I haven't examined this but relaying my
> > experiences), then it should be in a separate repository
> > (but the DTS and DTC should be in one place).
> > It was a little difficult to cobble together a working
> > system the first time.
> >
> > Also, mkimage SHOULD definitely go in the tree.  Its necessary
> > to build, hence should be in the tree...
> 
> Why?  mkimage is u-boot specific, and hence is maintained by u-boot.
> If you're not using u-boot, then you don't need mkimage.  What is
> wrong with it being a prereq like all the other tools we use?  If
> you're doing embedded development, you're installing non-distribution
> cross toolchain anyway.

The problem is that we build uImages at present, without option, for a
bunch of targets that don't necessarily have u-boot.

> dtc and mkimage are embedded development tools.  They belong with the
> embedded development toolchain.  mkimage is already part of ELDK.

dtc isn't just for embedded.  ps3 uses it already, and more may well
do so in future.

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
