From: Jim Thompson <jim@musenki.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Message-ID: <15565.24835.502552.949265@zaphod.musenki.com>
Date: Mon, 29 Apr 2002 10:04:35 -0500
To: =?gb2312?q?Dross=20Zhou?= <zjuzhou@yahoo.com.cn>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: How to mount romfs in flash as root filesystem?
In-Reply-To: <20020429141408.33240.qmail@web15001.mail.bjs.yahoo.com>
References: <20020429141408.33240.qmail@web15001.mail.bjs.yahoo.com>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Which kernel version?

Dross Zhou writes:
>
> MIME-Version: 1.0
> Content-Type: text/plain; charset=gb2312
> Content-Transfer-Encoding: 8bit
>
> Hi ,all
> 	Now my kernel has support ROMFS ,i can mount
> /dev/mtdblock0 /mnt -t romfs and use chroot /mnt as
> root filesystem.But i want to mount /dev/mtdblock0 as
> root filesystem when system reboot,how to?I have try
> many parameters into kernel such as "root=/dev/mtdblk0
> romfs ro", but it is no use, it also mount NFS
> root,how can i mount /dev/mtdblock0 (ROMFS) as root
> filesystem?I used linux2.4.4 from denx .
> 	thanks.
>
> --Zhou Chang
>
>
>
>
> 摊开你的掌心 让我看看你
> http://sweepstakes.yahoo.com/2002cnuser
>
>

--
"Life begins when you can spend your spare time programming
instead of watching television."  -- Cal Keegan


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
