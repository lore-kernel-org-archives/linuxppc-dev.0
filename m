To: "Wolfgang Denk" <wd@denx.de>
Cc: "Embedded Linux PPC list" <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: list of 2.6-related migration issues for embedded programmers?
References: <20040720134221.93224C109F@atlas.denx.de>
From: "Linh Dang" <linhd@nortelnetworks.com>
Date: Tue, 20 Jul 2004 12:07:28 -0400
In-Reply-To: <20040720134221.93224C109F@atlas.denx.de> (Wolfgang Denk's
 message of "Tue, 20 Jul 2004 09:42:16 -0400")
Message-ID: <wn5acxu8xxb.fsf@linhd-2.ca.nortel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On 20 Jul 2004, wd@denx.de wrote:

> In message <wn5vfgi9arw.fsf@linhd-2.ca.nortel.com> you wrote:
>>
>> But you don't have to. What ever you can do with the good-old
>> initrd image you can do with the new initramfs (really cpio
>> archive) image. The main difference is the creation: genext2fs vs
>> cpio.
>
> How do I populate a initramfs with custom device nodes?  Without
> having root permission, I mean.

You have a point here, I guess with initramfs you have to:

 - use devfs (which was deprecated in 2.6)
 - use udev
 - grok-sysfs-yourself (which is pretty easy)

>
> And how can I tell a Linux kernel where to find the initramfs data
> when they are not linked together?

Well, the same way as with the good old-initrd. the initramfs root-fs
IS an INITRD in compressed-cpio format (instead of fs format such as
ext2).


me think I'm still missing something about initrd.


Regards

--
L.D.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
