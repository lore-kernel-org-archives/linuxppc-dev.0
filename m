Date: Tue, 11 Jun 2002 19:51:30 -0700
From: Matt Porter <porter@cox.net>
To: Khai Trinh <kqtrinh@yahoo.com>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: Ebony bootloader
Message-ID: <20020611195130.C28767@home.com>
References: <20020611234337.46834.qmail@web11503.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20020611234337.46834.qmail@web11503.mail.yahoo.com>; from kqtrinh@yahoo.com on Tue, Jun 11, 2002 at 04:43:37PM -0700
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Tue, Jun 11, 2002 at 04:43:37PM -0700, Khai Trinh wrote:
>
> Does the Ebony board port implement a bootloader? What

It uses the "simple" bootloader.

> does the head_440.S file do in a nutshell?

init MMU and jump to start_kernel.

> If our custom board has peripheral devices hanging off
> the EBC0, how should I initilize them and where in the
> ebony port code? I browsed the source a little bit and
> see the ebony.c source. I believe this is where you
> add peripheral devices to the kernel. Am I right?

You can add then wherever you want, but ideally you would
create a <custom_board>.c with board specific I/O code.

> What is that ioremap64() anyway? Is this a kernel call
> or a called supported by the firmware?

Read Understanding Linux, Linux Device Drivers, and the
documentation in Documentation/ directory.  ioremap64()
is a version of ioremap() for >32-bit physical address
systems (440, 745x).

Regards,
--
Matt Porter
porter@cox.net
This is Linux Country. On a quiet night, you can hear Windows reboot.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
