Date: Thu, 3 Oct 2002 11:20:28 -0700
From: Matt Porter <porter@cox.net>
To: Paul Mackerras <paulus@samba.org>
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: 4xx file moving
Message-ID: <20021003112028.C5138@home.com>
References: <15772.16902.782403.737549@nanango.paulus.ozlabs.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <15772.16902.782403.737549@nanango.paulus.ozlabs.org>; from paulus@samba.org on Thu, Oct 03, 2002 at 11:11:34PM +1000
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Thu, Oct 03, 2002 at 11:11:34PM +1000, Paul Mackerras wrote:
>
> In an effort to keep the diffs between Linus' tree and linuxppc-2.5
> down, I am planning to send Linus (get Linus to pull) a changeset that
> will create arch/ppc/platforms/4xx and move files into it.  I plan to
> put the ibm*.[ch] files in arch/ppc/platforms/4xx, though, rather than
> arch/ppc/kernel/4xx, since those files are really almost entirely
> about what I/O devices are on the chip rather than anything to do with
> the core.
>
> That will mean that I will be moving those files in linuxppc-2.5 from
> arch/ppc/kernel/4xx to arch/ppc/platforms/4xx as well.  That leaves
> only a few files in arch/ppc/kernel/4xx, so I am not sure that it
> needs to exist, and I won't send Linus a changeset to create
> arch/ppc/kernel/4xx yet - not until I am convinced we need it.

I had the impression that the platforms/ directory was for platform
specific (in my mind, board-specific) files.  I would then imagine
that the ibm*.[ch] files would belong in kernel/.  They are similar
to the pplus_common.c and mpc10x_common.c libraries of code that
will be shared by many "platforms" (boards).  Anyway, I have been
working on the premise that board specific files go in platforms/
and shared code goes in kernel/.

I'd like to hear others interpretations and especially yours so
we are all on the same page.  IMHO, the above makes the most sense...
even for SoC processors like 4xx which can have peripherals
mix-and-matched in custom silicon runs in a similar puzzle fashion
to the many 7xx/74xx type embedded board designs we see. ;)

Regards,
--
Matt Porter
porter@cox.net
This is Linux Country. On a quiet night, you can hear Windows reboot.

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
