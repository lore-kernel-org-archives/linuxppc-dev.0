Message-ID: <20040823145515.29558.qmail@web15610.mail.cnb.yahoo.com>
Date: Mon, 23 Aug 2004 22:55:15 +0800 (CST)
From: Song Sam <samlinuxppc@yahoo.com.cn>
Subject: RE: How to check MTD partition content? 
To: Wolfgang Grandegger <wolfgang.grandegger@bluewin.ch>,
	Wolfgang Denk <wd@denx.de>
Cc: linuxppc-embedded <linuxppc-embedded@lists.linuxppc.org>
In-Reply-To: <40F7BFA600107805@mssbzhh-int.msg.bluewin.ch>
MIME-Version: 1.0
Content-Type: text/plain
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Wolfgang Grandegger <wolfgang.grandegger@bluewin.ch> wrote:

> >I followed the command in DULG to check partition content but
> >failed.Target console displayed no such command.
> >
> ># xd /dev/mtd3 | head -4
>
>http://www.denx.de/twiki/bin/view/DULG/FlashFilesystemsMTD
>
> >Could anyone show me a light?
>
> You can use any program to dump the data on the device, e.g. "od".
> Type "man od" for further information.

Thanks for your hints. I did it and could see the
content but not nice as expected as DULG said.

Fortunately, I searched the wanted command 'xxd'
rather than DULG had 'xd'.I guess it's a typo.So pls
Wolfgang Denk check it and make a correction.

root@172.16.115.7:/# od -tx /dev/mtd1 | head -4
0000000 27051956 552d426f 6f742031 2e312e32
0000020 20284175 67202037 20323030 34202d20
0000040 32323a34 313a3334 29000000 00000000
0000060 00000000 00000000 00000000 00000000

root@172.16.115.7:/# xxd /dev/mtd1 | head -4
0000000: 2705 1956 552d 426f 6f74 2031 2e31 2e32 '..VU-Boot 1.1.2
0000010: 2028 4175 6720 2037 2032 3030 3420 2d20 (Aug  7 2004 -
0000020: 3232 3a34 313a 3334 2900 0000 0000 0000 22:41:34).......
0000030: 0000 0000 0000 0000 0000 0000 0000 0000 ................

Best regards,

Sam

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
