Message-ID: <20040827083331.18765.qmail@web15610.mail.cnb.yahoo.com>
Date: Fri, 27 Aug 2004 16:33:31 +0800 (CST)
From: Song Sam <samlinuxppc@yahoo.com.cn>
Subject: Re: Cramfs Limitations 
To: Wolfgang Denk <wd@denx.de>
Cc: linuxppc-embedded@lists.linuxppc.org
In-Reply-To: <20040827073838.E2DD9C109F@atlas.denx.de>
MIME-Version: 1.0
Content-Type: text/plain
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Wolfgang Denk <wd@denx.de> wrote£º

> Why not? Of course you can. You just cannot write to it.

But I know little on application code's behavior. I
cannot adjust it's write operation, I am afraid.
It's another folk's job to code the application.

> > choice but use JFFS2 for deployment, which performance couldn't
> > compare with RAMDISK.It's a pity that RAMDISK cannot update some
> > info permanently. EXT2 seems not a
>
> You can use any filesystem, including one on a RAMDISK.

Good hints. I don't really want to give up RAMDISK for
it has a better performance than JFFS2 and EXT2.

> If the root filesystem happens to be read-only, you just need to
> provide a writable filesystem for those things that need to get
> written. In case of data that may

Recently, I have been thinking about to build up a
sector on FLASH for R/W operation, like JFFS2. Then my
root fileystem still keeps as RAMDISK. So I can get a
fastest boot process and write sector while running.
In your opinion, this way should work. Right?

> get lost at reboot you can use tmpfs, and for persistent storage you
> can use JFFS2.

tmfs is new to me but interesting. I will try it.

Thanks for your further help a lot!

Sam

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
