To: =?gb2312?q?Dross=20Zhou?= <zjuzhou@yahoo.com.cn>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: How to mount romfs in flash as root filesystem? 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Mon, 29 Apr 2002 22:14:08 +0800."
             <20020429141408.33240.qmail@web15001.mail.bjs.yahoo.com>
Date: Mon, 29 Apr 2002 16:35:24 +0200
Message-Id: <20020429143529.A188FFF68@denx.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


In message <20020429141408.33240.qmail@web15001.mail.bjs.yahoo.com> you wrote:
>
> 	Now my kernel has support ROMFS ,i can mount
> /dev/mtdblock0 /mnt -t romfs and use chroot /mnt as
> root filesystem.But i want to mount /dev/mtdblock0 as
> root filesystem when system reboot,how to?I have try
> many parameters into kernel such as "root=/dev/mtdblk0
> romfs ro", but it is no use, it also mount NFS

Probably because you mistyoed  the  device  name?  There  is  an  'o'
missing, it seems.

> root,how can i mount /dev/mtdblock0 (ROMFS) as root
> filesystem?I used linux2.4.4 from denx .

Just pass "root=/dev/mtdblock0", that's all.

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
I must follow the people.  Am I not their leader? - Benjamin Disraeli

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
