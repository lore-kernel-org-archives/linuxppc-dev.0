Message-ID: <3D53D947.7040309@galileo.co.il>
Date: Fri, 09 Aug 2002 18:01:27 +0300
From: Rabeeh Khoury <rabeeh@galileo.co.il>
MIME-Version: 1.0
To: "Xiaogeng (Shawn) Jin" <xjin@redswitch.com>
Cc: linux-mtd@lists.infradead.org,
	linuxppc-embedded@lists.linuxppc.org
Subject: Re: MTD/JFFS2 on Intel 28F160F3
References: <3D530222.7040303@redswitch.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


>
> The basic problem is what the physical start address of flash mapping
> is? While on PPCBoot, I got flash information using command 'flinfo'.
> The start address is FFE00000. Is this address the one used to configure
> CFI flash device in physical memeory map? I tried using this address but
>  'physmap' couldn't find flash device.

It is not a must that the address mapping in PPCBoot is the same as in
the kernel.

What board are you using ?


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
