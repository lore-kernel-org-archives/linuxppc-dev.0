Date: Fri, 7 Feb 2003 10:33:22 -0700
From: Matt Porter <porter@cox.net>
To: brian.auld@adic.com
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: Kernel build: not recognizing 'tlbre' instruction
Message-ID: <20030207103322.A14341@home.com>
References: <995FF289C9D69747A09E42992644595405B23656@penguin.adic.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <995FF289C9D69747A09E42992644595405B23656@penguin.adic.com>; from brian.auld@adic.com on Fri, Feb 07, 2003 at 08:23:43AM -0800
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Fri, Feb 07, 2003 at 08:23:43AM -0800, brian.auld@adic.com wrote:
> When I try to build this 'custom kernel', I get the following error:
>
> ...
> Unrecognized opcode: 'tlbre' in the file arch/ppc/kernel/misc.S

Your toolchain probably does not define -m405 and you must have a
kernel tree that does not have an arch/ppc/Makefile with the
following:

	ifdef CONFIG_4xx
	CFLAGS := $(CFLAGS) -Wa,-m405
	endif

> General question: Is there a way to get previous versions of
> linuxppc_2_4_devel kernels?

Do a "bk help" with the "clone" and "tag" args for an explanation on
how to clone a tree at a specific changeset or tag.

Regards,
--
Matt Porter
porter@cox.net
This is Linux Country. On a quiet night, you can hear Windows reboot.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
