Date: Sun, 10 Aug 2003 23:29:42 +0200
From: Samuel Rydh <samuel@ibrium.se>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: linuxppc-dev@lists.linuxppc.org,
	Paul Mackerras <paulus@samba.org>
Subject: Re: [PATCH] 2.6 timebase synchronization
Message-ID: <20030810212942.GB14877@ibrium.se>
References: <20030808001523.GA9274@ibrium.se> <20030809011305.GA12030@ibrium.se> <16181.43369.219750.258015@cargo.ozlabs.ibm.com> <1060508348.13388.20.camel@gaston>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1060508348.13388.20.camel@gaston>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Sun, Aug 10, 2003 at 11:39:08AM +0200, Benjamin Herrenschmidt wrote:
>
> On Sun, 2003-08-10 at 04:09, Paul Mackerras wrote:
> > Samuel Rydh writes:
> >
> > > Attached is an improved version of the patch.
> >
> > How many SMP machines are there where we don't know how to freeze/thaw
> > the timebase?  We know how to do that on the old powersurge powermacs,
> > on CHRP systems and on at least some of the recent core99 powermacs
> > (those that have a timebase-enable property on the cpu device nodes).
> > What machines are left?
>
> We know how to do it on some core99, though we don't actually do it
> yet ;) We use software sync on all core99 for now.

Btw, the freeze/thaw timebase setting that is done on psurge is lost
since the generic timebase calibration mechanism is still invoked
afterwards (and at that time, the timebases are ticking).

/Samuel


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
