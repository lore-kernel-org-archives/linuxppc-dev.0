Date: Thu, 14 Jan 1999 10:38:13 -0700 (MST)
From: Brad Midgley <brad@pht.com>
To: linuxppc-dev@lists.linuxppc.org
Subject: halt turns off dirty cache in hard drive?
Message-ID: <Pine.LNX.3.95.990114103321.18926A-100000@pacific.pht.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


hi,

i found a troubling problem. if i

 shutdown -r now

the root filesystem is clean when i get back into linux. however, if i

 shutdown -h now

the root filesystem has to be fsck'd. i only noticed this with the pre-x
kernel. the drive is a quantum 1225s connected to mesh. i am guessing from
this behavior that the latter command removes power from the drive while
its write cache is still dirty. any other possibilities? 

brad


[[ This message was sent via the linuxppc-dev mailing list. Replies are ]]
[[ not forced back to the list, so be sure to  Cc linuxppc-dev  if your ]]
[[ reply is of general interest. To unsubscribe from linuxppc-dev, send ]]
[[ the message 'unsubscribe' to linuxppc-dev-request@lists.linuxppc.org ]]
