Date: Sun, 1 Jun 2003 11:28:26 +0200
From: Magnus Damm <damm@opensource.se>
To: =?ISO-8859-1?Q?=B6=A1=BA=F1=D3=C0?= <nari_dhy@nari-china.com>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: file system over CF flash
Message-Id: <20030601112826.76f9978a.damm@opensource.se>
In-Reply-To: <012e01c327e7$fc8921c0$4c44900a@hydingnb>
References: <012e01c327e7$fc8921c0$4c44900a@hydingnb>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


There is no need for any special Flash file system, the Compact Flash itself keeps
track of things like wear levelling, sector size and command set of the flash devices.

The exported interface for a Compact Flash is just like any ATA Flash and under
Linux the standard IDE driver is normally used. The CF needs to be mapped into
some address space however, and this setup is usually taken care of by the PCMCIA
layer or the firmware/bootloader of your specific board.

So the Compact Flash itself does not limit you to any special kind of filesystem, but
I think the CF devices are shipped with some kind of FAT filesystem by default.

Then what this "xilinx virtex-ii pro eval board ML300" might assume is another thing.

/ magnus

On Sun, 1 Jun 2003 10:46:17 +0800
∂°∫Ò”¿ <nari_dhy@nari-china.com> wrote:

>
> There is a CF flash of IBM MicroDrive in xilinx virtex-ii pro eval board ML300.
> Can someone tell me what type of fs is used over such kind of flash device?
>
> thanks in advance
>
>


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
