Date: Mon, 7 Jun 2004 08:57:02 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Olaf Hering <olh@suse.de>
Cc: Christian Kujau <evil@g-house.de>, Andrew Morton <akpm@osdl.org>,
	linuxppc-dev@lists.linuxppc.org
Subject: Re: [PATCH] fix typo in binutils version check
Message-ID: <20040607155702.GX15195@smtp.west.cox.net>
References: <20040605074341.GA15279@suse.de> <40C1A334.5010402@g-house.de> <20040605111135.GA30640@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20040605111135.GA30640@suse.de>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Sat, Jun 05, 2004 at 01:11:35PM +0200, Olaf Hering wrote:
>
>  On Sat, Jun 05, Christian Kujau wrote:
>
> >
> > Olaf Hering wrote:
> > | The binutils check is bogus, it doesnt work with the just released
> > | binutils.
> >
> > why is this check bogus then? i tried to compile a kernel with some
> > recent binutils which didn't pass the test - compilation failed.
> > H.J.Lu's binutils [1] are working quite well, the releases from redhat
> > [2] seem to produce these results you wrote about.
>
> The checkbin target fails with current binutils cvs, you need an
> additional option like -many

IMHO, binutils CVS is broken, and -many shouldn't be needed.  But that's
not the direction things are heading apparently.

But I believe that when Paul talked about this with some of the binutils
folks it was decided that we should add -many to the AFLAGS so the
kernel won't have to care about this.  So can you add -many to the
AFLAGS, and make the binutils check use $(AFLAGS) as well?  Thanks.

--
Tom Rini
http://gate.crashing.org/~trini/

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
