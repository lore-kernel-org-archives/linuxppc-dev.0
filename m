Date: Wed, 13 Feb 2002 14:48:05 -0900
From: Ethan Benson <erbenson@alaska.net>
To: benh@kernel.crashing.org, linuxppc-dev@lists.linuxppc.org
Subject: Re: G4 boot crash problems with 2.4 "stable"
Message-ID: <20020213144805.K20789@plato.local.lan>
References: <20020213124811.28885@mailhost.mipsys.com> <Pine.LNX.3.96.1020213104616.6305C-100000@gatwood.net>
Mime-Version: 1.0
In-Reply-To: <Pine.LNX.3.96.1020213104616.6305C-100000@gatwood.net>; from dgatwood@gatwood.net on Wed, Feb 13, 2002 at 11:01:09AM -0800
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Wed, Feb 13, 2002 at 11:01:09AM -0800, David A. Gatwood wrote:
>
> On Wed, 13 Feb 2002 benh@kernel.crashing.org wrote:
>
> > A workaround for pmac or openpic ppc32 is to use the keylargo or the
> > openpic timer instead of the DEC. That could be a "kernel hacking" option
>
> Speaking of OpenPIC....  I tried to build a kernel from BK TOT last night
> for a PowerMac G4, and it hung about a half screen into booting after some
> yammering about OpenPIC.
>
> openpic enter
> openpic timer
> openpic ext
> (hang)
>
>
> Is there a 2.4 kernel source tarball around that is known to boot on
> Sawtooth (using BootX)?  Is there a way to yank the OpenPIC support?

http://penguinppc.org/projects/yaboot/doc/yaboot-howto.shtml

--
Ethan Benson
http://www.alaska.net/~erbenson/

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
