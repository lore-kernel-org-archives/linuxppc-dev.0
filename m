Date: Mon, 19 Jul 2004 15:06:21 -0400 (EDT)
From: "Robert P. J. Day" <rpjday@mindspring.com>
To: Linh Dang <linhd@nortelnetworks.com>
Cc: Embedded Linux PPC list <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: list of 2.6-related migration issues for embedded programmers?
In-Reply-To: <wn5ekn7amp7.fsf@linhd-2.ca.nortel.com>
Message-ID: <Pine.LNX.4.60.0407191505490.24105@dell.enoriver.com>
References: <Pine.LNX.4.60.0407191350320.23725@dell.enoriver.com>
 <wn5ekn7amp7.fsf@linhd-2.ca.nortel.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Mon, 19 Jul 2004, Linh Dang wrote:

> Don't use the .initramfs section option (the one that's linked with
> with vmlinux.) Build your ramdisk.image.gz as a compressed cpio
> archive. I.e. zvmlinux.initrd's .ramdisk section contains a compressed
> cpio archive instead of an compressed ext2 image.

that's all it takes?  that sounds just too easy.

rday

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
