Date: Fri, 14 Sep 2001 06:09:50 -0700
From: Matt Porter <mporter@mvista.com>
To: yah <hay8888@21cn.com>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: Romboot problem
Message-ID: <20010914060950.B12955@cx258813-a.chnd1.az.home.com>
References: <yJ989087856096.17193@webmail1.inner-21cn.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <yJ989087856096.17193@webmail1.inner-21cn.com>; from hay8888@21cn.com on Wed, Sep 12, 2001 at 02:39:03PM +0800
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Wed, Sep 12, 2001 at 02:39:03PM +0800, yah wrote:
>
> Hi,
>   I'm trying to boot Linux from my custom board (MCP750).I compiled the kernel using zimage.initrd. And it can boot correctly via net. But when I fill it in the onboard flash, the system can't boot. Here are the boot trace.

<snip>

This doesn't make sense.  Are you running a custom board or an MCP750?
Looks like PPCBUG to me so it must not be a custom board.

Anyway, MCP750 needs residual data to boot since it's part of the
PReP port.  Are you using the standalone bugboot package to
correctly create a PPCBUG rombootable image?  See
http://members.home.net/mmporter/linux/linuxppc/bugboot-0.3.tar.gz

--
Matt Porter
MontaVista Software, Inc.
mporter@mvista.com

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
