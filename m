Message-ID: <20020612113317.33359.qmail@web11508.mail.yahoo.com>
Date: Wed, 12 Jun 2002 04:33:17 -0700 (PDT)
From: Khai Trinh <kqtrinh@yahoo.com>
Subject: Re: Ebony bootloader
To: Matt Porter <porter@cox.net>
Cc: linuxppc-embedded@lists.linuxppc.org
In-Reply-To: <20020611195130.C28767@home.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Matt,

Thanks for the info. I have a follow up question. I am
trying to understand this whole embedded development
in general and not really a Linux specific question.
Are the board specific IO code setup to tell the
kernel the presence of the individual peripheral
devices on its bus (ie: the EBC0)? After that, a
driver is required for each device attach to the EBC0?
Is this driver a driver communicates to the EBC0 or a
driver communicates to the device thru the EBC0 device
memory map? Or my whole understanding is out of whack?

Thanks,
--Khai
--- Matt Porter <porter@cox.net> wrote:
> On Tue, Jun 11, 2002 at 04:43:37PM -0700, Khai Trinh
> wrote:
> >
> > Does the Ebony board port implement a bootloader?
> What
>
> It uses the "simple" bootloader.
>
> > does the head_440.S file do in a nutshell?
>
> init MMU and jump to start_kernel.
>
> > If our custom board has peripheral devices hanging
> off
> > the EBC0, how should I initilize them and where in
> the
> > ebony port code? I browsed the source a little bit
> and
> > see the ebony.c source. I believe this is where
> you
> > add peripheral devices to the kernel. Am I right?
>
> You can add then wherever you want, but ideally you
> would
> create a <custom_board>.c with board specific I/O
> code.
>
> > What is that ioremap64() anyway? Is this a kernel
> call
> > or a called supported by the firmware?
>
> Read Understanding Linux, Linux Device Drivers, and
> the
> documentation in Documentation/ directory.
> ioremap64()
> is a version of ioremap() for >32-bit physical
> address
> systems (440, 745x).
>
> Regards,
> --
> Matt Porter
> porter@cox.net
> This is Linux Country. On a quiet night, you can
> hear Windows reboot.


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
