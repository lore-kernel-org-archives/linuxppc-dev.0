From: pzawora@fideltronik.com
Date: Mon, 13 Aug 2001 12:32:44 +0200 (CEST)
To: Frank Przybylski <fp@vas-gmbh.de>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: NFS mounting timeout
In-Reply-To: <566C53CBBECCFF4D8D31B380F7B345FB016647@PICARD.nc1701.de>
Message-ID: <Pine.LNX.4.10.10108131207420.23782-100000@fideltronik.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Mon, 13 Aug 2001, Frank Przybylski wrote:

>
> Hi Pawel,
>
> > I use rom file system as a root fs. When I try to mount nfs in my root
> > fs an error occurs.
> > (mount -t nfs 192.168.1.1:/nfs /nfs)
> > After about 2 minutes kernel writes: "portmaper: time out".
> > What I should do?
>
> Check if the portmapper is running (both sides, server AND client), if
> not start it (usually /sbin/portmap).
>
> hth
>  Frank
>
I really don't use portmap on the client side. (my rom fs is small)
But there is possibe to mount and use nfs root fs without portmaper!
Today I set NFS_MOUNT_NONLM option (kenel doesn't call locked_up()
/fs/nfs/inode.c), but I'm not sure, that everything will be work OK ?
Thanks for help

Pawel Z


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
