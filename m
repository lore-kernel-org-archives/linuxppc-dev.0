Date: Mon, 7 Jan 2002 15:15:31 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: mod+linuxppc-dev@MissionCriticalLinux.com
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: Link-time failures from "simple" CFLAGS changes
Message-ID: <20020107221531.GA13931@cpe-24-221-152-185.az.sprintbbd.net>
References: <200201072201.RAA05808@missioncriticallinux.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <200201072201.RAA05808@missioncriticallinux.com>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Mon, Jan 07, 2002 at 05:01:51PM -0500, mod+linuxppc-dev@MissionCriticalLinux.com wrote:

> When I change -O2 to -O0 in my CFLAGS definition in Makefile thus:
[snip]
> ...I am astounded to see thousands of unresolved references
> at kernel link time.  WTF?  Any ideas?  These are the
> sorts of symbols that come up undefined:

You need at least -O1 for the kernel to compile.  I _think_ this is
documented somewhere even, but I don't recall where right now.

--
Tom Rini (TR1265)
http://gate.crashing.org/~trini/

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
