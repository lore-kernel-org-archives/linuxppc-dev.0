Date: Wed, 19 May 2004 14:04:38 -0700
From: Eugene Surovegin <ebs@ebshome.net>
To: Brian Hawley <bhawley@luminex.com>
Cc: Wolfgang Denk <wd@denx.de>, linuxppc-embedded@lists.linuxppc.org
Subject: Re: Ebony Board, PPC440GP and NFS panics
Message-ID: <20040519210438.GA13351@gate.ebshome.net>
References: <4.2.2.20040519101456.0509d340@bhawley.mailhost.luminex.com> <4.2.2.20040519123513.05074da0@bhawley.mailhost.luminex.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <4.2.2.20040519123513.05074da0@bhawley.mailhost.luminex.com>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Wed, May 19, 2004 at 12:36:50PM -0700, Brian Hawley wrote:
>
> At 09:54 PM 5/19/04 +0200, Wolfgang Denk wrote:
>
>
> >The question is: does your "arch/ppc/platforms/ebony.h" include
> ><asm/ppcboot.h> or not, i. e. does it use the U-Boot definitions at
> >all?
>
> There is no ebony.h in arch/ppc/platforms...the board isn't listed there at
> all, neither
> is the walnut [ 405 ], but I've seen numerous people discuss the fact that
> they have
> the ebony board working with this (linux-2.5-ocp from bk) working.

It's arch/ppc/platforms/4xx/ebony.[ch]

And no, ebony.[ch] doesn't support u-boot. So it cannot work with u-boot if you
didn't change ebony.[ch].

You cannot just substitute boot loader without changing board support in Linux
kernel and expect it to work.

I can only suggest the same thing I told you before, get Ebony running with
standard IBM boot loader (OpenBIOS), study how Linux kernel interact with _this_
bootloader, study how u-boot differs from IBM OpenBIOS and only after having
full understanding how things work, try to port Ebony to using u-boot.

Eugene.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
