Date: Thu, 3 Jan 2002 14:58:46 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Stefan Jeglinski <jeglin@4pi.com>
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: do_mounts.c parse error
Message-ID: <20020103215846.GD749@cpe-24-221-152-185.az.sprintbbd.net>
References: <p04330106b85a7acfa489@[63.220.231.138]>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <p04330106b85a7acfa489@[63.220.231.138]>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Thu, Jan 03, 2002 at 04:28:15PM -0500, Stefan Jeglinski wrote:

> I still get a parse error in 2.5.2-pre5 (bk mirror) in
> init/do_mounts.c, as reported for -pre1. I've tried scoring the code
> for typos but I can't find one. Is this just a dumb typo I'm missing,
> or something more subtle?

Not sure.  But who said 2.5.x is going to compile out of the box anyhow?
Which reminds me, I'm going to push 2.5.2-pre6 soon, and almost nothing
is compiling in that. :)

--
Tom Rini (TR1265)
http://gate.crashing.org/~trini/

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
