Date: Tue, 1 Oct 2002 14:31:32 -0700
From: Matt Porter <porter@cox.net>
To: Aman <aman@mistralsoftware.com>
Cc: linuxppc embedded <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: Downloading Linux image using Riscwatch
Message-ID: <20021001143132.A32379@home.com>
References: <3D6BB90D.FEA66532@redswitch.com> <001c01c24df2$76195030$370da8c0@aman> <001201c23a50$1057cf20$370da8c0@aman>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <001201c23a50$1057cf20$370da8c0@aman>; from aman@mistralsoftware.com on Fri, Aug 02, 2002 at 11:41:46PM +0530
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Fri, Aug 02, 2002 at 11:41:46PM +0530, Aman wrote:
> I am using PPC 440GP processor on custom board. This board doesnt not have
> Ethernet support and there is no rom monitor code in the board. Is it
> possible to download the Linux image to the board using JTAG . If so what
> type of image should I build.

The arch/ppc/boot/images/zvmlinux.* file is a standard ELF image.
Your tool should either allow you to load that format directly
or should accept a format to which it can be easily converted.

Regards,
--
Matt Porter
porter@cox.net
This is Linux Country. On a quiet night, you can hear Windows reboot.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
