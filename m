Date: Thu, 6 Sep 2001 15:25:43 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: andrew may <acmay@acmay.homeip.net>
Cc: linuxppc-commit@source.mvista.com,
	linuxppc-embedded@lists.linuxppc.org
Subject: Re: patch for mktree.c on cross compiles
Message-ID: <20010906152543.S21172@cpe-24-221-152-185.az.sprintbbd.net>
References: <20010905120613.I14548@ecam.san.rr.com> <3B968E75.A63F26EA@mvista.com> <20010905212050.K18940@cpe-24-221-152-185.az.sprintbbd.net> <20010905223903.D621@sink.san.rr.com> <20010906075542.A21172@cpe-24-221-152-185.az.sprintbbd.net> <20010906130106.L14548@ecam.san.rr.com> <20010906140852.R21172@cpe-24-221-152-185.az.sprintbbd.net> <20010906135432.M14548@ecam.san.rr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20010906135432.M14548@ecam.san.rr.com>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Thu, Sep 06, 2001 at 01:54:32PM -0700, andrew may wrote:
> > Yes, it's an imperfect solution at best.  What would be correct is for us
> > to copy all of the needed magic into our own header and toss it in
> > arch/ppc/boot/include.  With some proper magic for the !Linux case too.
>
> I am not sure why we would need to do this. mktree.c already includes
> libc headers and the htonl defination is pulled in with them.

htonl works, it's just non-obvious.  It should be on anything that
conforms to BSD 4.3, so it should hopefully be fine for cross-platform.

--
Tom Rini (TR1265)
http://gate.crashing.org/~trini/

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
