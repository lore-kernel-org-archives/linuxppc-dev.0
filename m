Message-ID: <39BFEA3F.70687DFE@snmc.com>
Date: Wed, 13 Sep 2000 15:57:35 -0500
From: Daris A Nevil <dnevil@snmc.com>
MIME-Version: 1.0
To: "Min-kyu, Joo" <zzu@cesys.ajou.ac.kr>
CC: linuxppc-embedded@lists.linuxppc.org
Subject: Re: I want to find flash device driver...
References: <000e01c01db8$b5289ea0$481877d3@ajou.ac.kr>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Joo,

QSLinux contains a fully functioning FLASH driver, and an interface to
the Ext2FS filesystem, with compression.  You can find the source at
ftp://qslinux.org, and documentation at http://qslinux.org.

Regards,
Daris Nevil


"Min-kyu, Joo" wrote:
>
> I use flash in Linux...
> I want to use flash after booting linux, making filesystem and mounting flash, and read and write to flash...
> So I need flash device driver...
> I wrote driver code for flash..because my linux read compressed kernel image from flash..
> But when I access flash from system call(open, read, write), it seems to be some problem..
>
> Does anyone know where can I get flash device driver for linux?
>
> --zzu--
>

--
Daris A Nevil
Simple Network Magic Corporation
401 Kentucky Lane
McKinney, TX 75069
214-793-7757
dnevil@snmc.com
www.snmc.com
quickstack.com
qslinux.org

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
