Return-Path: <owner-linuxppc-embedded@lists.linuxppc.org>
To: "Embedded Linux PPC list" <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: list of 2.6-related migration issues for embedded programmers?
References: <20040720071610.7BC31C109F@atlas.denx.de>
From: "Linh Dang" <linhd@nortelnetworks.com>
Date: Tue, 20 Jul 2004 07:29:55 -0400
In-Reply-To: <20040720071610.7BC31C109F@atlas.denx.de> (Wolfgang Denk's
 message of "Tue, 20 Jul 2004 03:16:05 -0400")
Message-ID: <wn5vfgi9arw.fsf@linhd-2.ca.nortel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On 20 Jul 2004, wd@denx.de wrote:

> In message <wn5zn5v8nl8.fsf@linhd-2.ca.nortel.com> you wrote:
>>
>> - I failed to see what in initramfs mechanism would prevent
>> one from having "separated images which can be updated
>> independently of each other."
>
> initramfs gets linked with the kernel into one image, similar to

But you don't have to. What ever you can do with the good-old initrd
image you can do with the new initramfs (really cpio archive)
image. The main difference is the creation: genext2fs vs cpio.

I just happen to use zImage.initrd (where ramdisk.image.gz is a cpio
archive) in our project because it's the most appropriate for our
situation.

Regards

--
L.D.


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
