Message-ID: <20040807073904.67622.qmail@web15606.mail.cnb.yahoo.com>
Date: Sat, 7 Aug 2004 15:39:04 +0800 (CST)
From: Song Sam <samlinuxppc@yahoo.com.cn>
Subject: Re: How to remove JFFS2 'Making dirty' display on RPXlite DW?
To: David Woodhouse <dwmw2@infradead.org>,
	Mark Chambers <markc@mail.com>, David Ho <DavidHo@nanometrics.ca>
Cc: linuxppc-embedded@lists.linuxppc.org
In-Reply-To: <1091716260.4383.4617.camel@hades.cambridge.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


David Woodhouse <dwmw2@infradead.org> wrote£º
> > After unpacking SELF,I use the following command to create a jffs2
> > filesystem:
> >
> > eraseall /dev/mtd3
> >
> > mkfs.jffs2 -r /tmp/tmp -e 0x10000 -o image.jffs2 -b
>
> Looks like you should have said '-e 256KiB' or '-e 0x40000' instead.

After taking your advice,the JFFS2 complaint
disappeared.The command I tested is as follows,it
worked fine:

eraseall /dev/mtd3

mkfs.jffs2 -r /tmp/tmp -e 0x40000 -o /dev/mtd3 -b

Thanks for you all.

Next,I will take Wolfgang's advice on decreasing boot
time to create an ext2+mini_fo filesystem based on MTD
 to get a faster boot process.By now the boot time of
my target is 18-20
seconds(48MHZ[CORE]+24MHZ[BUS]+uncompressed
kernel+JFFS2).

Best regards,

Sam

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
