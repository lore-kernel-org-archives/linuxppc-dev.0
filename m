Date: Wed, 3 Feb 1999 22:56:21 -0700 (MST)
From: Brad Midgley <brad@pht.com>
To: Paul.Mackerras@cs.anu.edu.au
cc: linuxppc-dev@lists.linuxppc.org
Subject: rsync kernel is incomplete
In-Reply-To: <199902040142.MAA03853@tango.anu.edu.au>
Message-ID: <Pine.LNX.3.95.990203225338.8064A-100000@pacific.pht.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


paul,

could you open drivers/uusbd?

rsync -avz samba.anu.edu.au::linux-pmac-devel /mnt/nfs/linux
 [...]
receiving file list ... opendir(drivers/uusbd): Permission denied

thanks
brad


[[ This message was sent via the linuxppc-dev mailing list. Replies are ]]
[[ not forced back to the list, so be sure to  Cc linuxppc-dev  if your ]]
[[ reply is of general interest. To unsubscribe from linuxppc-dev, send ]]
[[ the message 'unsubscribe' to linuxppc-dev-request@lists.linuxppc.org ]]
