Date: Mon, 17 Nov 2003 13:49:46 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Wolfgang Denk <wd@denx.de>
Cc: linuxppc-dev@lists.linuxppc.org,
	Dale Farnsworth <dale@farnsworth.org>
Subject: Re: MPC5xxx code issues
Message-ID: <20031117204946.GI30251@ip68-0-152-218.tc.ph.cox.net>
References: <20031117202944.GH30251@ip68-0-152-218.tc.ph.cox.net> <20031117204320.E0605C5F59@atlas.denx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20031117204320.E0605C5F59@atlas.denx.de>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Mon, Nov 17, 2003 at 09:43:15PM +0100, Wolfgang Denk wrote:
>
> in message <20031117202944.GH30251@ip68-0-152-218.tc.ph.cox.net> you wrote:
> >
> > Must clean: These files need some sort of rewrite to look less like
> > a drop of commerical code into the kernel and more like working the
> > commercial code into the kernel:
> > arch/ppc/5xxx_io/bestcomm/capi/Makefile
> > arch/ppc/5xxx_io/bestcomm/code_dma/image_rtos1/Makefile
> > arch/ppc/5xxx_io/bestcomm/code_dma/image_rtos2/Makefile
> > arch/ppc/5xxx_io/bestcomm/include/dummy files (should these be needed?)
>
> I recommend NOT to touch anything in the bestocmm directory. This
> stuff is supplied directly by Motorola, and it is more than likely
> that new versions of this code will have to be dropped in soon.

I'd like to point to the xilinx_ocp directory in linuxppc_2_4_devel.
While Xilinx is probably more concerned with the code being in the
Linux kernel than Motorola (but I could be wrong), the OS-independant
code is still always the same.
Since I wasn't explicit enough, I'm hoping we can rewrite the Makefiles
(which shouldn't be too hard to keep in sync as it should end up being
just changing the file lists) and that the dummy files can just be
removed and ignored.

--
Tom Rini
http://gate.crashing.org/~trini/

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
