Date: Sat, 15 Mar 2003 13:09:35 +0000
From: John Levon <levon@movementarian.org>
To: Andrew Fleming <afleming@motorola.com>
Cc: oprofile-list@lists.sourceforge.net,
	linuxppc-dev@lists.linuxppc.org
Subject: Re: PowerPC Performance Interrupt
Message-ID: <20030315130935.GD64159@compsoc.man.ac.uk>
References: <227DFA1D-5665-11D7-8667-000393C30512@motorola.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <227DFA1D-5665-11D7-8667-000393C30512@motorola.com>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Fri, Mar 14, 2003 at 03:37:20PM -0600, Andrew Fleming wrote:

> So, it seems to me that in PowerPC, we need to get the
> already-installed PerfMon exception handler to call into oprofile.

Well I don't know ppc but this sounds OK

> Another method would be to register the pid of a control app (perhaps
> in /proc), and then have the PerfMon interrupt send a SIG_PROF to
> whichever app was registered.  I'm not sure what the consequences are

This would be very slow, overloads the meaning of SIGPROF, and wouldn't
work anyway with oprofile which needs the post-processing in
drivers/oprofile/buffer_sync.c

regards
john

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
