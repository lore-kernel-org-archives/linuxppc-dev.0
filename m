Date: Fri, 24 Jan 2003 10:38:02 -0800
From: Chris Zimman <chris@cryptoapps.com>
To: brian.auld@adic.com
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: Status of 440GP support?
Message-ID: <20030124183802.GA21151@mail.cryptoapps.com>
Reply-To: Chris Zimman <chris@cryptoapps.com>
References: <995FF289C9D69747A09E42992644595405B23621@penguin.adic.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <995FF289C9D69747A09E42992644595405B23621@penguin.adic.com>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Fri, Jan 24, 2003 at 10:13:16AM -0800, brian.auld@adic.com wrote:
> 1) After looking at the source tree for linuxppc_2_4 and linuxppc_2_4_devel,
> it appears that 440GP support is only in linuxppc_2_4_devel. Does
> linuxppc2_4_devel mean "unstable", or is it simply the latest and greatest
> ppc kernel code for the 2.4 series that is stable.

The latter -- the trees just haven't been merged yet.

> 2) I'm going through iterations of make menuconfig  (on linuxppc_2_4_devel
> tree) to try and get a kernel for the 440GP successfully built and am not
> having much success. Does anyone have a ".config" file that works that I
> could take a look at? Should it compile out of the box? I set up my
> cross-compile tools using the following:
>   -> binutils-2.12.90.0.12
>   -> gcc-3.2.1 (with gcc-3.2-crossppc.diff patch applied)

See arch/ppc/configs/ebony_defconfig

One way (there may be better ways) is:

cp arch/ppc/configs/ebony_defconfig .config
make oldconfig

> 3) I plan to use 'Das U-Boot' as my boot loader. Any other snafus/gotchas
> anyone would be willing to let me in on ahead of time??

Works fine for me.

--Chris

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
