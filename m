Message-ID: <3D197D61.6060205@cambridgebroadband.com>
Date: Wed, 26 Jun 2002 09:37:53 +0100
From: Alex Zeffertt <ajz@cambridgebroadband.com>
MIME-Version: 1.0
To: Steven Scholz <steven.scholz@imc-berlin.de>
Cc: LinuxPPC <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: SELF and JFFS2????
References: <3D1961E6.AEB50722@imc-berlin.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Maybe you could change the Makefile so that it creates symbolic links to /bin/busybox instead of
hardlinks.  The only drawback to this is that you end up using one inode per link, instead of one
inode for all the links.  As long as you've got the space to waste this won't be a problem.

Alex

Steven Scholz wrote:

> Hi there,
>
> has anyone successfully used DENX SELF to create an root fs _and_ put it then on
> a JFFS2 partion?
>
> I would like to create a flash disk just as easy as you can create a ramdisk
> with SELF.
> But for now the problem is that mkfs.jffs2 does _not_ handle (busybox) hardlinks
> correctly - well at least not the way I want.
>
> Thanks,
>
> Steven
>
>
>


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
