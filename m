Date: Thu, 16 Aug 2001 07:54:53 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Paul Mackerras <paulus@samba.org>
Cc: Scott Carroll <scottcar@us.ibm.com>,
	linuxppc-dev@lists.linuxppc.org
Subject: Re: Power3 problem?
Message-ID: <20010816075453.A26735@cpe-24-221-152-185.az.sprintbbd.net>
References: <20010815145449.A16297@entropy.crashing.org> <20010815150115.A25310@cpe-24-221-152-185.az.sprintbbd.net> <15227.631.494933.982093@cargo.ozlabs.ibm.com> <20010815162545.C25310@cpe-24-221-152-185.az.sprintbbd.net> <15227.4822.809371.11593@cargo.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <15227.4822.809371.11593@cargo.ozlabs.ibm.com>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Thu, Aug 16, 2001 at 10:24:54AM +1000, Paul Mackerras wrote:
> Tom Rini writes:
>
> > Well, pretending is a bad choice of words.  They are real chrp machines,
> > but they aren't 'ALL_PPC', since you can't run on a power3 and a 604 :)
>
> No, but if you had a prep or pmac with a power3 cpu, you could run the
> same vmlinux as on a chrp power3. :)

Well, true...

> > Well, I don't think it will be as bad as that.  It _should_ be possible
> > to split them out, and move the functions it uses from pmac_setup.c into
> > a common file.  If I have time I'll play with it sometime and post patches.
> > If it can be done cleanly, I don't think it'd be a bad idea, but...
>
> There is an argument for splitting out prep but I would rather keep
> pmac and chrp together since they are quite similar.

I think there's lots of good reasons to either split or not split some things
out.  I also think we should probably wait until 2.5 to do any of it.
I also think we should discuss multi platform support a bit more.  I'll
start that in a different email in a bit..

--
Tom Rini (TR1265)
http://gate.crashing.org/~trini/

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
