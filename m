Message-ID: <20040308022549.97042.qmail@web15204.mail.bjs.yahoo.com>
Date: Mon, 8 Mar 2004 10:25:49 +0800 (CST)
From: =?gb2312?q?song=20sam?= <samsongshzu@yahoo.com.cn>
Subject: Re: PCI daughter card with USB on a 405GP
To: Matt Porter <mporter@kernel.crashing.org>
Cc: Wolfgang Denk <wd@denx.de>,
	Xavier Miville <xmiville@oerlikon.ca>, v.sudeep@exgate.tek.com,
	linuxppc-embedded@lists.linuxppc.org
In-Reply-To: <20040305105421.67799.qmail@web15202.mail.bjs.yahoo.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Dear Mr. Matt,

I mistook your 405 patch on 8xx for
test.Actually,there is a perfect solution for RPXlite
USB in HOST mode problem on Brad Parker's webpage.
http://www.heeltoe.com/software/usb/usb.html

Egg on face! I should be blamed to disturb you all.

I list the README of m8xxhci driver 1.4 as follows for
clarification.After removing R74/R75(1.5K) as two
20Ks(I only have 20K at hand) to ground on LITE_DW,USB
keyboard worked fine.

Best regards,

Sam

[ Brad Parker <brad@heeltoe.com> wrote: ]
>
> m8xxhci driver 1.4 USB Host controller driver for Motorola MPX 8xx
> (823/850)
>
> The latest testing for this driver has been done on a modified
> RPX_LITE DW 823e board.
>
> The modification is to remove R74 and R75 and add 15k "pull down"
> resistors from the signal pads to ground. (i.e. figure out which
> pad of R74 and R75 is the D+/D- and add a resistor from that pad to
> ground).
>
> This, coupled with the DW board's 48mhz sysclk routing and DRQ1#
> routing, allows the board to be a USB host controller.
>
> This driver disables kernel "printk" when a device is connect. The
> printk turns off interrupts for long periods of time which causes bad
> SOF's to be sent. The microcode patch requires that it be serviced
> ever 1ms or corrupted SOF's are sent out.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
