Date: Fri, 18 Jun 2004 08:51:09 +0200
From: Marc Leeman <marc.leeman@barco.com>
To: m madhuker <mythri_madhuker@yahoo.com>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: NFS probelm in MPC8245
Message-ID: <20040618065109.GH10248@smtp.barco.com>
Reply-To: Marc Leeman <marc.leeman@barco.com>
References: <20040618061127.50148.qmail@web13601.mail.yahoo.com>
Mime-Version: 1.0
In-Reply-To: <20040618061127.50148.qmail@web13601.mail.yahoo.com>
Content-Type: text/plain; charset=iso-8859-15
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


> -C >targets/
> oky, what is this target.scn.tar.gz...and why???

I did not write this for you, I just wrote it for internal use on our
intranet. So the filenames might be slightly off.

> where we get it..

You can get a PPC target from ELDK (somewhere on ftp.leo.org). It should
be name accordingly; search Wolfgang's site for the details.

> as u said :in kernel configuration of board ..
> >Have you configured the kernel to activate BOOTP?
> >CONFIG_IP_PNP_BOOTP=y
> >CONFIG_NFS_FS=y
> >CONFIG_ROOT_NFS=y
>i had enabled these all.

And recompiled and loaded the NFS kernel on the target board?

> oky, when i run this command:
> ]#/etc/init.d/nfs restart
> it is getting restarted oky,..

I hope this is on the NFS server machine?

> iam getting some erors that "configuration file has errors"

You should close all the brackets you open, there is one missing at the
end.

> ]# "mount -t nfs [ip]:/hostresource  /mnt "
> iam getting following o/p:

How can you mount your root FS on your board after you have boot it.

> sir, one doubt.. to mount NFS in board...

Wait, do you want to mount just a simple share or do you want to mount
your root FS on the board, ...

If it's just an NFS share, then there's some missunderstanding here.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
