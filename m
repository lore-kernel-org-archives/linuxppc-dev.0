Date: Fri, 8 Aug 2003 10:56:41 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Giuliano Pochini <pochini@shiny.it>,
	LinuxPPC-dev <linuxppc-dev@lists.linuxppc.org>
Subject: Re: 2.4.22p10 compile error
Message-ID: <20030808175641.GB8475@ip68-0-152-218.tc.ph.cox.net>
References: <20030807232737.20df47f2.pochini@shiny.it> <20030808170309.GA8475@ip68-0-152-218.tc.ph.cox.net> <1060362726.653.5.camel@gaston>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1060362726.653.5.camel@gaston>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Fri, Aug 08, 2003 at 07:12:07PM +0200, Benjamin Herrenschmidt wrote:
>
> > It looks like your copy of the rsync tree is missing files.  Please
> > update the tree and try again.
>
> My bk clone does that too:
>
> make _sfdep_chrp _sfdep_pmac _sfdep_prep _FASTDEP_ALL_SUB_DIRS="chrp pmac prep"
> make[4]: Entering directory `/home/benh/kernels/linuxppc_benh_devel/arch/ppc/boot/prep'
> make -C chrp fastdep
> make: *** chrp: No such file or directory.  Stop.

Looking harder, yeah, that does seem to be a bug.  Why is it going all
the way into arch/ppc/boot/prep/ before doing a 'make -C chrp'...

--
Tom Rini
http://gate.crashing.org/~trini/

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
