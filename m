Message-ID: <20040308041510.59522.qmail@web15202.mail.bjs.yahoo.com>
Date: Mon, 8 Mar 2004 12:15:10 +0800 (CST)
From: =?gb2312?q?song=20sam?= <samsongshzu@yahoo.com.cn>
Subject: Solution of USB in HOST mode on RPXLITE DW 823e board
To: linuxppc-embedded@lists.linuxppc.org
In-Reply-To: <20040305105421.67799.qmail@web15202.mail.bjs.yahoo.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi,

I posted this message for clarification of USB problem
in HOST mode on RPXLITE DW 823e board.There were some
'complaint's when using USB host mode.Under the
instrution of Brad Parker,the problem was solved fine.
Following is README of m8xxhci driver 1.4 from Brad
Parker's webpage.
http://www.heeltoe.com/software/usb/usb.html

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
