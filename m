Date: Tue, 28 Aug 2001 19:10:46 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: linuxppc-commit@source.mvista.com,
	linuxppc-dev@lists.linuxppc.org
Subject: Re: Remove some stuff from arch/ppc/boot/Makefile... (2_4_devel)
Message-ID: <20010828191046.F15262@cpe-24-221-152-185.az.sprintbbd.net>
References: <20010828184504.E15262@cpe-24-221-152-185.az.sprintbbd.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20010828184504.E15262@cpe-24-221-152-185.az.sprintbbd.net>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Tue, Aug 28, 2001 at 06:45:04PM -0700, Tom Rini wrote:

> 1) Some minor makefile magic $(var:foo=bar)

Which now that I think about it can die anyhow.  The filter magic we do
later on should work fine still, so it can just be
ifeq ($(CONFIG_ALL_PPC),y)
subdir-y := chrp prep pmac.

> 2) subdir-m kludge to get a .depend file.

Which kills this I think.  I knew I shoulda thought about this a bit more.
Thanks for letting me fill your inboxes a bit more. :)

--
Tom Rini (TR1265)
http://gate.crashing.org/~trini/

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
