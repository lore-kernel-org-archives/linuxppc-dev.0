Message-ID: <3D10680F.7020800@gmx.de>
Date: Wed, 19 Jun 2002 13:16:31 +0200
From: Michael Habermann <MHabermann@gmx.de>
MIME-Version: 1.0
To: zhongqx <zhongqx@guoguang.com.cn>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: Kernel panic:I have no root and I want to scream
References: <000801c216a3$e8fb5160$7301a8c0@zhongqx>
Content-Type: text/plain; charset=GB2312
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


zhongqx wrote:
> ## Loading RAMDisk Image at 00600000 ...
>    Image Name:   ramdisk
>    Image Type:   PowerPC Linux RAMDisk Image (gzip compressed)
>    Data Size:    428 Bytes = 0 kB = 0 MB

Seems your ramdisk image has problems. 428 byte is certainly too small.


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
