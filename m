Date: Thu, 30 Jan 2003 13:37:43 -0700
From: Matt Porter <porter@cox.net>
To: brian.auld@adic.com
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: Trying to use ELDK to build Ebony/440GP
Message-ID: <20030130133743.A25221@home.com>
References: <995FF289C9D69747A09E42992644595405B23634@penguin.adic.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <995FF289C9D69747A09E42992644595405B23634@penguin.adic.com>; from brian.auld@adic.com on Thu, Jan 30, 2003 at 11:06:12AM -0800
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Thu, Jan 30, 2003 at 11:06:12AM -0800, brian.auld@adic.com wrote:
> (2) What's the best method to successfully build a kernel for the ebony
> board using the ELDK tools:
>      - Port ebony support into e-new?
>      - Try and work out build issues with 2_4_d configured for 'ebony'.
>
> Wanted to solicit some feedback before I go into tangent land.

I can't imagine why any ppc4xx toolchain couldn't build a properly
configured linuxppc_2_4_devel ebony kernel.  It's working right now
for my toolchain (mvista)...I haven't used ELDK for a little while now.

I take you have done the following?:

	make ebony_config
	make oldconfig
	make dep zImage

Where you have hacked ARCH and CROSS_COMPILE in the top-level Makefile
or have a script which passes in the appropriate prefix for your
toolchain.  i.e. "make ARCH=ppc CROSS_COMPILE=ppc_405- <rule>"

Regards,
--
Matt Porter
porter@cox.net
This is Linux Country. On a quiet night, you can hear Windows reboot.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
