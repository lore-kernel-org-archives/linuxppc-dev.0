To: "zhongqx" <zhongqx@guoguang.com.cn>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: Kernel panic: No init found. Try passing init= option to kernel 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Fri, 13 Sep 2002 07:37:18 +0800."
             <000b01c25ab5$559edc10$7301a8c0@zhongqx>
Date: Sat, 14 Sep 2002 14:50:26 +0200
Message-Id: <20020914125031.A8E1EFA8D@denx.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


In message <000b01c25ab5$559edc10$7301a8c0@zhongqx> you wrote:
>
>     I want to use ramdisk instead of NFS for my linux on FADS860T which has 2M flash and 8M ram.I want to use eldk pakages to make ramdisk. but when i use it to boot linux ,it print the following message:

You can use our SELF package as  a  model  to  build  custom  ramdisk
images (see ftp://ftp.denx.de/pub/LinuxPPC/usr/src/SELF/).

> EXT2-fs warning: mounting unchecked fs, running e2fsck is recommended
> VFS: Mounted root (ext2 filesystem).
> Freeing unused kernel memory: 56k init
> Kernel panic: No init found.  Try passing init= option to kernel.

> I am sure that /bin/sh exist.why linux can not execute it

Are you sure it's executable, i. e. it really  runs  in  the  ramdisk
environment?  You  can  test  ramdisk  directory  trees  easily using
"chroot".

> successfully? but when I use the simple-ramdisk.PPCBoot which i
> download frow file://ftp.denx.de:/pub/LinuxPPC/usr/src,it run well
> like following:

...which is a pretty reliable indication that yoiur ramdisk image  is
incomplete.

>     Why Simple-ramdisk.PPCBoot is ok but My ramdisk.image is not ok,i cant find the diffrent from this two, ths sh program need libray all exist,why linux cant excute successfully?
>     Can someone give me help ? thank you in advanced!

Without more information about how you generated  your  ramdisk,  and
what you actually put into it, we cannot even guess.

My recommendation is to start with working tools, like SELF.

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
There are always alternatives.
	-- Spock, "The Galileo Seven", stardate 2822.3

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
