Date: Thu, 22 Jul 2004 10:38:37 -0700
From: Matt Porter <mporter@kernel.crashing.org>
To: Markus Bernauer <markus.bernauer@freenet.de>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: Booting Ebony-evb with u-boot and linux-devel-sourcetree from Denx
Message-ID: <20040722103837.A17686@home.com>
References: <40FFAB78.1000705@freenet.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <40FFAB78.1000705@freenet.de>; from markus.bernauer@freenet.de on Thu, Jul 22, 2004 at 01:56:40PM +0200
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Thu, Jul 22, 2004 at 01:56:40PM +0200, Markus Bernauer wrote:
> I am trying to boot my Ebony-evb with u-boot and a kernel image generated
> from devel-sourcetree from Denx. It seems to me like the kernel image simply
> ignores the parameters handed over by u-boot. I also found some earlier
> threads
> that  support my thoughts. Unfortunately I am bound to u-boot and I am
> not able
> to switch back to the native bootloader that comes with the evb. Has anyone
> already a system up and running booted by u-boot? At first it does not
> matter whether
> the root filesystem comes from flash or over nfs. Any hints would be
> appreciated.

If somebody has time to support u-boot properly, I'd be happy to apply
the patch to the ebony port.  The current port relies on OpenBIOS since
it gathers the MAC addresses from the defined VPD space.  Some people
run with u-boot/ebony, but I gather they just hack the MAC address
code and use the kernel cmdline option.

It would be nice if somebody submitted a patch to make it u-boot
friendly, it's just not high on my TODO list.

-Matt

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
