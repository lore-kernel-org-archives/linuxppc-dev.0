To: "Embedded Linux PPC list" <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: list of 2.6-related migration issues for embedded programmers?
References: <Pine.LNX.4.60.0407191350320.23725@dell.enoriver.com>
From: "Linh Dang" <linhd@nortelnetworks.com>
Date: Mon, 19 Jul 2004 14:14:44 -0400
In-Reply-To: <Pine.LNX.4.60.0407191350320.23725@dell.enoriver.com> (Robert
 P. J. Day's message of "Mon, 19 Jul 2004 13:51:57 -0400")
Message-ID: <wn5ekn7amp7.fsf@linhd-2.ca.nortel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On 19 Jul 2004, rpjday@mindspring.com wrote:

> On Mon, 19 Jul 2004, Linh Dang wrote:
>
>> On 19 Jul 2004, rpjday@mindspring.com wrote:
>
>>> - initramfs:  currently, i'm still using a zImage.initrd-based
>>> image, and all i know about initramfs is that it's checked for at
>>> boot time.  should i care about it?  at some point, probably, i'm
>>> sure.
>>
>> initramfs is convenient. you don't need root access nor special
>> tools to create the root-fs. it very easy when you want to
>> version-controlled you root-fs.
>
> ah, that would be convenient since, as it is, i'm using a hacked
> version of "genext2fs" that allows me to create the initial root fs
> as a regular user.  i *definitely* have to look into initramfs,
> then.

Don't use the .initramfs section option (the one that's linked with
with vmlinux.) Build your ramdisk.image.gz as a compressed cpio
archive. I.e. zvmlinux.initrd's .ramdisk section contains a compressed
cpio archive instead of an compressed ext2 image.

--
L.D.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
