Subject: Re: problems with compiling glibc
To: rolfl@sc.mcel.mot.com (Rolf Liu)
Date: Wed, 26 Apr 2000 17:30:33 +1000 (EST)
Cc: linuxppc-dev@lists.linuxppc.org
In-Reply-To: <001001bfb1b3$de9fa510$e50102c8@d-pengl-229.sc.mcel.mot.com> from "Rolf Liu" at Apr 29, 2000 03:21:07 AM
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-Id: <20000426073033.3427A1B172@elph.research.canon.com.au>
From: greyham@research.canon.com.au (Graham Stoney)
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Rolf Liu writes:
> /home/lhx/powerpc-linux/bin/ld: unrecognised emulation mode: elf32ppclinux
> Supported emulations: elf32ppc
...
> I wonder if elf32ppclinux is  different from elf32ppc ?

They are the same. The latest official GNU gcc and binutils releases are
currently out of step in this regard. You can fix it either by:
1. upgrading to a more recent Linux binutils release, or
2. upgrading to a more recent official binutils snapshot, or
3. editing your gcc specs file to use elf32ppc instead of efl32ppclinux

Regards,
Graham

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
