Message-ID: <407EDCF7.2020009@buckeye.ece.drexel.edu>
Date: Thu, 15 Apr 2004 15:05:27 -0400
From: Sharad Gupta <sharad@buckeye.ece.drexel.edu>
MIME-Version: 1.0
To: LinuxPPC <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: System ACE MPU interface to CF card
References: <407470ED.3030607@buckeye.ece.drexel.edu> <6058-40021@sneakemail.com> <407ADCFE.8080302@buckeye.ece.drexel.edu> <25757-52278@sneakemail.com>
In-Reply-To: <25757-52278@sneakemail.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Stephen Williams wrote:

> The attached patch demonstrates how I enabled the SYSACE driver
> for my (JSE) board. I'm not so sure I'm happy with it, because
> each board will have to do something similar. I'm thinking that
> the CONFIG_XILINX_SYSACE define should lose its dependence on
> CONFIG_XILINX_OCP, but I'm not clear on the best way to account
> for this in the xilinx_ocp/Makefile.

Thanks Stephen,

Your patch helped me a lot in compiling and configuring my kernel. Just
on a side note, have you been able to talk to compact flash (mount fs on
it, fsck it ?) through system ace ?

My kernel hangs while doing partition check on the drive. All I ever see is

Partition check:
xsysacea:

(then nothing happens)

I am using SanDisk's 128MB CF card and system ace is configured in the
byte mode. Any pointers as to why it is not going ahead will be highly
appreciated.

Thanks
Sharad.


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
