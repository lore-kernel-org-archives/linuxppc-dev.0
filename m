Message-ID: <20040827013550.73877.qmail@web15605.mail.cnb.yahoo.com>
Date: Fri, 27 Aug 2004 09:35:50 +0800 (CST)
From: Song Sam <samlinuxppc@yahoo.com.cn>
Subject: Re: Cramfs Limitations 
To: Wolfgang Denk <wd@denx.de>
Cc: linuxppc-embedded@lists.linuxppc.org
In-Reply-To: <20040826151246.43D26C109F@atlas.denx.de>
MIME-Version: 1.0
Content-Type: text/plain
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Wolfgang Denk <wd@denx.de> wrote£º

> > INIT: can't open(/etc/ioctl.save,O_WRONLY):Permission denied!
> >
> > What's on earth with it?Could 2_4_devel or 2.6 fix it?
>
> Are you really surprised that opening a file for writing fails on a
> read-only filesystem???

So only for this reason, I cannot choose Cramfs for my
application deployment??? Then I have nearly no other
choice but use JFFS2 for deployment, which performance
couldn't compare with RAMDISK.It's a pity that RAMDISK
cannot update some info permanently. EXT2 seems not a
good idea for FLASH. I really feel puzzled with my
30MB application code deployment.

Thanks very much for your input!

Sam

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
