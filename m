Date: Mon, 15 Sep 2003 08:14:38 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Hollis Blanchard <hollisb@us.ibm.com>
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: combine PPC "general setup" and "platform setup"?
Message-ID: <20030915151438.GC29517@ip68-0-152-218.tc.ph.cox.net>
References: <08392963-E571-11D7-AC00-000A95A0560C@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <08392963-E571-11D7-AC00-000A95A0560C@us.ibm.com>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Fri, Sep 12, 2003 at 05:32:46PM -0500, Hollis Blanchard wrote:

> In 2.5's menuconfig there are now two "general setup" sections; one is
> generic and one is ours. We also have a "platform setup" section. It
> seems like all our "general setup" questions could be folded into
> "platform setup", e.g. "Workarounds for PPC601 bugs" and "Support for
> Open Firmware device tree in /proc". Can we get rid of our "general
> setup"?

I suspect it's an artifact of before we had init/Kconfig.  In theory, we
certainly should.  But if we kill it outright, our 'platform setup' gets
quite large.  How about a bus options menu, like i386 has to break this
up a bit (and some movement of options with that) ?

--
Tom Rini
http://gate.crashing.org/~trini/

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
