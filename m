Date: Tue, 20 Jul 2004 08:32:27 -0400 (EDT)
From: "Robert P. J. Day" <rpjday@mindspring.com>
To: Linh Dang <linhd@nortelnetworks.com>
Cc: Embedded Linux PPC list <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: list of 2.6-related migration issues for embedded programmers?
In-Reply-To: <wn5vfgi9arw.fsf@linhd-2.ca.nortel.com>
Message-ID: <Pine.LNX.4.60.0407200830400.4974@localhost.localdomain>
References: <20040720071610.7BC31C109F@atlas.denx.de> <wn5vfgi9arw.fsf@linhd-2.ca.nortel.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Tue, 20 Jul 2004, Linh Dang wrote:

>
> On 20 Jul 2004, wd@denx.de wrote:
>
>> In message <wn5zn5v8nl8.fsf@linhd-2.ca.nortel.com> you wrote:
>>>
>>> - I failed to see what in initramfs mechanism would prevent
>>> one from having "separated images which can be updated
>>> independently of each other."
>>
>> initramfs gets linked with the kernel into one image, similar to
>
> But you don't have to. What ever you can do with the good-old initrd
> image you can do with the new initramfs (really cpio archive)
> image. The main difference is the creation: genext2fs vs cpio.
>
> I just happen to use zImage.initrd (where ramdisk.image.gz is a cpio
> archive) in our project because it's the most appropriate for our
> situation.

i have to agree with wolfgang here -- how would you create and use an
initramfs image separately from the kernel image?  the only
possibility i can see based on my perusal is to incorporate the
initramfs into the zImage.initrd.

rday

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
