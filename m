Date: Wed, 17 Nov 1999 03:59:03 +0000 (   )
From: John Buswell <johnb@one.net>
To: linuxppc-dev@lists.linuxppc.org
Subject: Re: mkext2 on a mac ide disk
In-Reply-To: <Pine.LNX.3.96.991117034438.17776A-100000@shell>
Message-ID: <Pine.LNX.3.96.991117035819.17776B-100000@shell>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Wed, 17 Nov 1999, John Buswell wrote:

> mke2fs 1.15, 18-Jul-1999 for EXT2 FS 0.5b, 95/08/09
> /dev/hdc10: Invalid argument passed to ext2 library while setting up
> superblock 

doh.. i added apple disk label support to my kernel and rebooted and it
works fine.. 


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
