Date: Sat, 15 Jun 2002 08:10:21 -0700
From: Matt Porter <porter@cox.net>
To: Khai Trinh <kqtrinh@yahoo.com>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: Ebony bootloader
Message-ID: <20020615081021.A737@home.com>
References: <20020611195130.C28767@home.com> <20020612113317.33359.qmail@web11508.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20020612113317.33359.qmail@web11508.mail.yahoo.com>; from kqtrinh@yahoo.com on Wed, Jun 12, 2002 at 04:33:17AM -0700
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Wed, Jun 12, 2002 at 04:33:17AM -0700, Khai Trinh wrote:
> Matt,
>
> Thanks for the info. I have a follow up question. I am
> trying to understand this whole embedded development
> in general and not really a Linux specific question.
> Are the board specific IO code setup to tell the
> kernel the presence of the individual peripheral
> devices on its bus (ie: the EBC0)? After that, a

Correct.  This is for cases where we want to write
a driver that is shared across multiple core and
board implementations.

> driver is required for each device attach to the EBC0?

Correct.

> Is this driver a driver communicates to the EBC0 or a
> driver communicates to the device thru the EBC0 device
> memory map? Or my whole understanding is out of whack?

It is a standalone kernel driver for the device connected
via the EBC.  There is no "driver" for the EBC itself.

Regards,
--
Matt Porter
porter@cox.net
This is Linux Country. On a quiet night, you can hear Windows reboot.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
