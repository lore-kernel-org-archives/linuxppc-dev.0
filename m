In-Reply-To: <20040805042134.41548.qmail@web15610.mail.cnb.yahoo.com>
Subject: Re: How to remove JFFS2 'Making dirty' display on RPXlite DW?
To: Song Sam <samlinuxppc@yahoo.com.cn>
Cc: linuxppc-embedded@lists.linuxppc.org
Message-ID: <OF8088850E.40FE160C-ON85256EE7.004A1422-85256EE7.004A576A@nanometrics.ca>
From: David Ho <DavidHo@nanometrics.ca>
Date: Thu, 5 Aug 2004 09:31:59 -0400
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


> When creating a JFFS2 filesytem with DENX SELF ramdisk
> as follows,the target displayed some wired
> message,what would be problem be?
>
> =====================================================
>
> After unpacking SELF,I use the following command to
> create a jffs2 filesystem:
>
> eraseall /dev/mtd3
>
> mkfs.jffs2 -r /tmp/tmp -e 0x10000 -o image.jffs2 -b
>
> dd if=image.jffs2 of=/dev/mtd3 bs=256k
>
> mount -t jffs2 /dev/mtdblock3 /mnt
>
> ====================================================

What is the block size you specified when you do a mkfs.jffs2?

It has to match with your flash erase block size.  Care should be taken if
you have paralle banks.

I'm not sure this is your problem but it is a problem I ran into.

David

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
