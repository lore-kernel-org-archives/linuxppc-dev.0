Message-ID: <3E09132D.5020606@gmx.de>
Date: Wed, 25 Dec 2002 10:08:45 +0800
From: Michael Habermann <mhabermann@gmx.de>
MIME-Version: 1.0
To: Omanakuttan <omanakuttan@tataelxsi.co.in>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: starting position of linux kernel in memory -- ppc
References: <3E082775.1040503@tataelxsi.co.in>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Omanakuttan wrote:

> We have ordered for a demo on the target board (8260ADS) and they are
> asking for kernel with start address at 0x0000_0000.
> How will I see that info in the kernel ? Or by default it will place
> itself on 0x0000_0000 ?
>
The kernel assumes that some intialisations have been done before it
starts, so you need a bootloader like u-boot.


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
