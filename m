Message-ID: <3DD2212B.3070902@esd-electronics.com>
Date: Wed, 13 Nov 2002 10:53:47 +0100
From: Matthias Fuchs <matthias.fuchs@esd-electronics.com>
MIME-Version: 1.0
To: linuxppc-embedded <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: Accessing nvram rom the linux users space
References: <3D296C067098F149B11A8F4FC37C05462F21DD@EXVS1.ops.infiniswitch.com> <3DD15BF9.6050500@rmsweldingsystems.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi Mike,

you probably can check out if the "MTD Test driver using RAM" might
help you. This MTD driver uses memory mapped SRAM (or in your case NVRAM).

But all filesystem bring a huge overhead. With 32K of NVRAM you will not
have much usable place for you data in the files left.

You should consider using part of your flash for storing data in
MTD block devices with filesystems (e.g. JFFS2).

I think the mmap example for the NVRAM that I send to you is a good and efficent
solution for the NVRAM.


Matthias


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
