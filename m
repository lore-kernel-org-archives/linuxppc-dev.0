Message-Id: <v04003a00b2e5b9267ae5@[204.22.210.180]>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Date: Tue, 9 Feb 1999 10:22:55 +0000
To: linuxppc-dev@lists.linuxppc.org
From: "sean o'malley" <somalley@ed.mde.state.mi.us>
Subject: multi networks
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


I have a powerbook, and i use it on three distinctly different networks.

Is there something in the kernel that loads sort of a network lilo or like
the location manager that will let you have multiple sets of network
settings?

My thinking on this is that it would just pop up a short menu before
loading the network settings. than it would just copy or link the files
from a master set, like location1.hosts (converesly hosts.location1) and
than it could load the correct network setting. for the network your on.
or maybe even change them on the fly after boot. this would also have to
include swtiching from DHCP, modem and different static ip's.

or is there already soemthing like this?

Sean




[[ This message was sent via the linuxppc-dev mailing list. Replies are ]]
[[ not forced back to the list, so be sure to  Cc linuxppc-dev  if your ]]
[[ reply is of general interest. To unsubscribe from linuxppc-dev, send ]]
[[ the message 'unsubscribe' to linuxppc-dev-request@lists.linuxppc.org ]]
