Subject: Re: NFS mounting timeout
Date: Mon, 13 Aug 2001 13:17:17 +0200
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Message-ID: <566C53CBBECCFF4D8D31B380F7B345FB016649@PICARD.nc1701.de>
From: "Frank Przybylski" <fp@vas-gmbh.de>
To: <pzawora@fideltronik.com>
Cc: <linuxppc-embedded@lists.linuxppc.org>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi again,

> I really don't use portmap on the client side. (my rom fs is small)
> But there is possibe to mount and use nfs root fs without portmaper!
> Today I set NFS_MOUNT_NONLM option (kenel doesn't call locked_up()
> /fs/nfs/inode.c), but I'm not sure, that everything will be work OK ?

You could try:
'mount -t nfs 192.168.1.1:/nfs /nfs -o nolock' to disable the lockd
accesses. I'm not quite sure about the impacts. At least you can not
rely on file locking anymore... ;-). With this option you should be able
to mount nfs without the portmapper and without recompiling.

hth
 Frank

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
