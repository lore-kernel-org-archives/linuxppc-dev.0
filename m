From: Paul Mackerras <paulus@samba.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <15227.4822.809371.11593@cargo.ozlabs.ibm.com>
Date: Thu, 16 Aug 2001 10:24:54 +1000 (EST)
To: Tom Rini <trini@kernel.crashing.org>
Cc: Scott Carroll <scottcar@us.ibm.com>,
	linuxppc-dev@lists.linuxppc.org
Subject: Re: Power3 problem?
In-Reply-To: <20010815162545.C25310@cpe-24-221-152-185.az.sprintbbd.net>
References: <20010815145449.A16297@entropy.crashing.org>
	<20010815150115.A25310@cpe-24-221-152-185.az.sprintbbd.net>
	<15227.631.494933.982093@cargo.ozlabs.ibm.com>
	<20010815162545.C25310@cpe-24-221-152-185.az.sprintbbd.net>
Reply-To: paulus@samba.org
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Tom Rini writes:

> Well, pretending is a bad choice of words.  They are real chrp machines,
> but they aren't 'ALL_PPC', since you can't run on a power3 and a 604 :)

No, but if you had a prep or pmac with a power3 cpu, you could run the
same vmlinux as on a chrp power3. :)

> Well, I don't think it will be as bad as that.  It _should_ be possible
> to split them out, and move the functions it uses from pmac_setup.c into
> a common file.  If I have time I'll play with it sometime and post patches.
> If it can be done cleanly, I don't think it'd be a bad idea, but...

There is an argument for splitting out prep but I would rather keep
pmac and chrp together since they are quite similar.

Paul.

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
