Date: Thu, 2 Aug 2001 16:51:02 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Val Henson <val@nmt.edu>
Cc: linuxppc-commit@source.mvista.com,
	linuxppc-dev@lists.linuxppc.org
Subject: Re: Incoming to hostme.bitkeeper.com:/ua/repos/p/ppc/bk/linuxppc_2_4_devel
Message-ID: <20010802165102.N13516@opus.bloom.county>
References: <20010802230759.9D6AE106D6@hostme.bitkeeper.com> <20010802162546.M13516@opus.bloom.county> <20010802174236.A3183@boardwalk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20010802174236.A3183@boardwalk>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Thu, Aug 02, 2001 at 05:42:36PM -0600, Val Henson wrote:

> Didn't we just have a huge arch/ppc/boot reorganization?

Who said it's done?  We made it a lot less of a problem, and at least a
bit less ugly.  Now I'm getting around to finishing it up.  For example,
there's no reason really that pmon, pcore, spruce, menf1, pp3 and sandpoint
along with 'PReP' and quite probably even gemini can't share the same
very early init code.  8xx/4xx can use almost all of head.S and probably
other code too.  So why should we have 6-7 different copies of the same
code?  For example, the L1 bits that everyone copied weren't wholly
correct.  This wasn't noticed until Dan Malek did some sandpoint work and
I got him to look at others.  With everyone sharing the same file(s) everyone
gets the same fixes.

--
Tom Rini (TR1265)
http://gate.crashing.org/~trini/

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
