Message-Id: <4.3.2.20001108174258.00b96420@falcon.si.com>
Date: Wed, 08 Nov 2000 17:48:04 -0500
To: linuxppc-embedded@lists.linuxppc.org
From: Jerry Van Baren <vanbaren_gerald@si.com>
Subject: Re: mvme2604 - using Gabriel's patches. NFS questions.
In-Reply-To: <OFEA5E744C.0F7B4EBE-ON86256991.007989AD@collins.rockwell.c
 om>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Root is initially mounted RO on power up.  Are you remounting it RW?
# mount -n -o remount,rw /

 From /etc/rc.d/rc.sysinit:
action "Remounting root filesystem in read-write mode" mount -n -o
remount,rw /

gvb


At 04:29 PM 11/8/00 -0600, jlhagen@collins.rockwell.com wrote:

>Hi,
>
>I have two mvme2604 boards that are up and running with root mounted NFS
>using Gabriel's patches against 2.2.12 kernel. The boot messages for the
>boards always report " VFS: Mounted root (NFS filesystem) read-only".  Not
>knowing NFS that well, is there a way I can change it so the boards mount
>the file system as read/write? I do have the nfs sever /etc/exports file
>set for "  /tftpboot/192.168.1.5      vme(rw, no_root_squash)"  read/write
>as I understand it. Might be a stupid question but I need to be
>enlightened.
[snip]


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
