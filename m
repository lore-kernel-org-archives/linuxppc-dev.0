Date: Tue, 9 Apr 2002 15:39:16 -0600
From: Stephen Cameron <steve.cameron@compaq.com>
To: linuxppc-embedded@lists.linuxppc.org
Subject: IBM walnut, gcc, NIC and recent kernel?
Message-ID: <20020409153916.A5306@zuul.cca.cpqcorp.net>
Reply-To: steve.cameron@compaq.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi,

Lately I find myself playing around with this IBM walnut
board and hardhat linux 1.2 with a 2.4.0 based kernel,
cross compiling with Montavista's gcc on an intel box.

I'd like to use a more recent kernel, but I have
some questions.

I downloaded 2.4.18 along with the powerpc patch from
kernel.org.

Then, changed the Makefile to set CROSS_COMPILE = to
montavista's compiler, and ARCH = ppc.

Then it seems the walnut's network driver turns up missing,
so I tried copying over the *405*.[ch] files from the drivers/net
directory of the 2.4.0 montavista kernel. (realizing that's
probably not going to work straightaway) and hacked the
Config.in to try to make it attempt a compile.

Well, the assembler complained about some "unsupported
relocation type" in ppc4xx_pic.o, so I suspect I need a
newer gcc, assembler, etc. (had nothing to do with network
driver, I think)

So, it occurs to me that other folks must be using this walnut,
and perhaps solved these problems already.

So if someone has recommendations about a specific recent kernel
that works well with the walnut, and has network support for it,
that'd be nice.

Also any hints on getting gcc & friends to work for intel->ppc
cross compiler with a recent kernel would be appreciated.

Also, if I'd be better off sticking with hardhat linux (or
something else) for an embedded application than trying to
use the kernel.org kernels for some reasons, please feel
free to educate me about that.

Thanks,

-- steve


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
