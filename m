Return-Path: <owner-linuxppc-embedded@lists.linuxppc.org>
Date: Tue, 10 Aug 2004 14:47:57 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Song Sam <samlinuxppc@yahoo.com.cn>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: Boot time with several filesystems on RPXlite DW
Message-ID: <20040810214757.GL22109@smtp.west.cox.net>
References: <20040807062126.8EF1BC109F@atlas.denx.de> <20040809145454.46774.qmail@web15609.mail.cnb.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20040809145454.46774.qmail@web15609.mail.cnb.yahoo.com>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Mon, Aug 09, 2004 at 10:54:54PM +0800, Song Sam wrote:

> I used several filesystems based on MTD vs ramdisk to
> test boot time on RPXlite DW and got the following
> result:
[snip]
> IP-Config: Complete:
>       device=eth0, addr=172.16.115.7,
> mask=255.255.255.0, gw=172.16.115.254,
>      host=172.16.115.7, domain=, nis-domain=(none),
>      bootserver=172.16.115.6, rootserver=172.16.115.6,
> rootpath=
> NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
> VFS: Mounted root (jffs2 filesystem).
[snip]
> I would be satisfied with less than 8 seconds in my
> case.Any ideas?

Try trimming down the .config.  For example, it doesn't look like you
need IP_PNP enabled as you aren't NFSrooting and can just bring the
interface up later.

--
Tom Rini
http://gate.crashing.org/~trini/

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
