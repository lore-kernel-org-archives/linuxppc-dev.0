Date: Wed, 28 Nov 2001 10:49:26 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Joseph Manojlovich <manojlov@cse.psu.edu>
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: 'make rpm' Failing due to i386 bug
Message-ID: <20011128104926.C28956@cpe-24-221-152-185.az.sprintbbd.net>
References: <20011127233224.C23109@cardassian.cse.psu.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20011127233224.C23109@cardassian.cse.psu.edu>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Tue, Nov 27, 2001 at 11:32:24PM -0500, Joseph Manojlovich wrote:

> Hey all. I was using the latest stable branch from source.mvista.com,
> and noticed that 'make rpm' wasn't working. Looking closer, I noticed
> that a supporting script, scripts/mkspec, is quite 386 specific. It
> makes an rpm spec file that assumes the kernel image is compressed,
> which with ppc it isn't (for me at least).

You could try %ifarch ppc ... %else .. %endif.  Tho we do have a
'bzImage' target, and yaboot might even do the 'zimages' on pmac as well
as chrp now.  Talk to Alan Cox since this is his script anyhow.

--
Tom Rini (TR1265)
http://gate.crashing.org/~trini/

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
