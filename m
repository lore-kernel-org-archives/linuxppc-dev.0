Subject: Re: How to remove JFFS2 'Making dirty' display on RPXlite DW?
From: David Woodhouse <dwmw2@infradead.org>
To: Song Sam <samlinuxppc@yahoo.com.cn>
Cc: linuxppc-embedded@lists.linuxppc.org
In-Reply-To: <20040805042134.41548.qmail@web15610.mail.cnb.yahoo.com>
References: <20040805042134.41548.qmail@web15610.mail.cnb.yahoo.com>
Content-Type: text/plain
Message-Id: <1091716260.4383.4617.camel@hades.cambridge.redhat.com>
Mime-Version: 1.0
Date: Thu, 05 Aug 2004 15:31:00 +0100
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Thu, 2004-08-05 at 12:21 +0800, Song Sam wrote:
> Hi,
>
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

Looks like you should have said '-e 256KiB' or '-e 0x40000' instead.

--
dwmw2


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
