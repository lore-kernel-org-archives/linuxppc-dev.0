Message-ID: <3CEABE26.4480791C@kegel.com>
Date: Tue, 21 May 2002 14:37:42 -0700
From: Dan Kegel <dank@kegel.com>
Reply-To: dank@kegel.com
MIME-Version: 1.0
To: andrew may <acmay@acmay.homeip.net>
Cc: "linuxppc-embedded@lists.linuxppc.org" <linuxppc-embedded@lists.linuxppc.org>,
	Bryan Rittmeyer <bryan@ixiacom.com>
Subject: Re: khttpd crash verified with vanilla linuxppc_2_4_devel
References: <3CEAAEFF.3D274083@kegel.com> <20020521141643.D20012@ecam.san.rr.com>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


andrew may wrote:
>
> On Tue, May 21, 2002 at 01:33:03PM -0700, Dan Kegel wrote:
> >
> > I can crash khttpd at will on a totally vanilla
> > linuxppc_2_4_devel kernel as of changeset 1.749
> > using an open source load generator, with or without
> > the patch that fixes a khttpd crash on x86
> > ( http://www.kegel.com/linux/khttpd/khttpd-unbork.patch ).
> >
> > This crash is not present on the imac with current kernels, nor
> > in Hard Hat 2.0 on this same board, nor on the PC with current kernels.
> > I believe it's a bug in the linuxppc_2_4_devel trunk.
>
> What filesystem are you using? RAMfs?

Good point.  All the good runs were either with
ramfs or ext2/3, all the bad runs were with tmpfs.
I should vary that.

> Can you try the imac using the same FS?

Will do!

FWIW, I verified that changeset 1.654 behaves badly with khttpd, too
(still with tmpfs).
- Dan

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
