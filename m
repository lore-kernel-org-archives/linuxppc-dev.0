Date: Sun, 23 Sep 2001 13:54:41 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Wolfgang Denk <wd@denx.de>
Cc: Dan Malek <dan@mvista.com>,
	Linuxppc-Embedded <linuxppc-embedded@lists.linuxppc.org>,
	Linuxppc-Commit <linuxppc-commit@source.mvista.com>
Subject: Re: CPCI-405 port (PPC405GP)
Message-ID: <20010923135441.C1878@cpe-24-221-152-185.az.sprintbbd.net>
References: <3BAA0C91.42E0910D@mvista.com> <20010923180123.979C61009E@denx.denx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20010923180123.979C61009E@denx.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Sun, Sep 23, 2001 at 08:01:18PM +0200, Wolfgang Denk wrote:
> In message <3BAA0C91.42E0910D@mvista.com> you wrote:
>
> > the purposes of the bootloader is to isolate these changes into the
> > bootloader.
>
> As long as you don't create incompatible  _interfaces_  there  is  no
> problem.

Well, 2.5/2.6 _will_ be incompatible with 2.4.  But it should also be
possible for bootloaders to work for both.

> > The bootloader is a critical part to initializing the environment for
> > the kernel.  With all of the MMU futzing around we do trying to get
> > Linux running, Ben and I have discussed yet another better bootloader
> > method to move some of this around between the bootloader and the
> > kernel start up.  There are also initrd and command line things done
> > by the bootloader (among other board specific initialization).  It's
> > more than whether or not we all use bi_recs.
>
> Please keep in mind that PPCBoot exists, and is used on MANY  boards.
> Even  when you don't use it yourself, I ask you not to break compati-
> bility without GOOD reason. Also, I'd appreciate a little  discussion
> with  the PPCBoot folks before such changes happen. You know where to
> find us.

Well, this was on linuxppc-dev at least once.  Possibly twice.  And at
least once more before we actually do this.  2.5 will be incompatible
since everyone whose spoken before has agreeded that the current methods
aren't 100%.  If you wanna make a case for moving everyone to the way
PPCBoot talks to the kernel, please do.

--
Tom Rini (TR1265)
http://gate.crashing.org/~trini/

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
