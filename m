Date: Wed, 15 Aug 2001 13:43:48 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: clark@esteem.com
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: Loading Hard Hat 2.0
Message-ID: <20010815134348.N15482@cpe-24-221-152-185.az.sprintbbd.net>
References: <5.0.0.25.1.20010815131839.0208f070@pop.esteem.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <5.0.0.25.1.20010815131839.0208f070@pop.esteem.com>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Wed, Aug 15, 2001 at 01:33:56PM -0700, clark@esteem.com wrote:

> 	Has anybody loaded Hard Hat 2.0 Linux Journeyman edition on Red Hat 7.1
> yet? I know its been asked before, but I was wondering if the answer has
> changed from no.

RedHat 7.1 is not a supported target.  See below.

> 	Is there an easy way to install Hard Hat 2.0 without removing my 1.0
> 	install?

Normally, yes.  But, I _think_ the main reason RedHat 7.1 isn't supported
is that the version of RPM shipped by default does NOT support relocation,
so you can't install HHL 2.0 into another subdir and have 1.x and 2.0
co-exist.

--
Tom Rini (TR1265)
http://gate.crashing.org/~trini/

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
