Date: Wed, 8 Aug 2001 08:53:17 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: John F Davis <johndavi@us.ibm.com>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: MVista: CDK 1.2 2.2.14 for SBS-K2 (750) Module Support
Message-ID: <20010808085317.N2399@cpe-24-221-152-185.az.sprintbbd.net>
References: <OF205CEC3C.F52A4B97-ON85256AA2.0049AD5B@raleigh.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <OF205CEC3C.F52A4B97-ON85256AA2.0049AD5B@raleigh.ibm.com>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Wed, Aug 08, 2001 at 09:10:22AM -0400, John F Davis wrote:

> We are trying to build a kernel with loadable modules support using a stock
> mvista CDK 1.2 toolset.  The
> error is that many symbols are not resolved correctly.  If I build without
> module
> support the kernel builds fine.

The very short answer is modules don't work (which you've noticed), and if
you don't have a compelling reason to stay on CDKit 1.2, please upgrade
to 2.0, which won't have this problem.  The slightly longer answer is,
i think, the K2 build didn't link in ppc_ksyms.o when built w/ module
support.  I _think_.

--
Tom Rini (TR1265)
http://gate.crashing.org/~trini/

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
