From: "Hendricks, Kevin" <khendricks@ivey.uwo.ca>
To: Benjamin Herrenschmidt <bh40@calva.net>
Cc: Michel Ddnzer <daenzerm@student.ethz.ch>, linuxppc-dev@lists.linuxppc.org
Message-ID: <39AFCE61.7D68ED0C@ivey.uwo.ca>
Date: Fri, 01 Sep 2000 11:42:25 -0400
MIME-Version: 1.0
Subject: Re: asm statement in include/asm not ansi conform
References: <39AFC193.D492A0B@student.ethz.ch> <20000901152428.28366@mailhost.mipsys.com>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi,

> When someone finally decide to implement code that checks if we have or
> not a PC BIOS from which we can read the values. It's on my (long)
> todolist, I was more or less hoping that Kostas would do it before me,
> especially since I don't have an x86 card to test with.

As I remember things, the xf4 code does do a simple check to see if there is a
bios present.  I once enabled this code and found out on my B+W G3 machine, it
passed that bios test but read completely bogus values (even if you converted
the data for endian issues) whereas on my G4, it completely failed the simple
bios check that was present.

Without a real xf86 card with a bios present to play with, there is really no
way to try and devise a better test.  Even if a bios is present, wouldn't OF
still do the initialization?

I think we should submit it as is and ifdef it to powerpc and forget about it
until we find out what is up.

By the way, either way, the values calculated by that code should be fine (as
long as the main code clock rate is 2950) whether intialized by OF or an actual
bios so no real harm should be done (certainly better than their hardcoded
values used now).

My 2 cents.

Kevin

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
