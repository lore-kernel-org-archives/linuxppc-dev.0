Message-ID: <36AD6257.F1F3354C@talknet.de>
Date: Tue, 26 Jan 1999 06:36:07 +0000
From: Alois Fertl <alois_fertl@TalkNet.de>
MIME-Version: 1.0
To: "linuxppc-dev@lists.linuxppc.org" <linuxppc-dev@lists.linuxppc.org>
Subject: SHMMAX on ppc
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


I wonder if there is a reason why SHMMAX is set to a limit of 0x3fa000
on ppc
beside that it is probably taken from the alpha port. I run into this on
running
cdrecord-1.6.1 from the xcdroast-0.96e package.

Alois


[[ This message was sent via the linuxppc-dev mailing list. Replies are ]]
[[ not forced back to the list, so be sure to  Cc linuxppc-dev  if your ]]
[[ reply is of general interest. To unsubscribe from linuxppc-dev, send ]]
[[ the message 'unsubscribe' to linuxppc-dev-request@lists.linuxppc.org ]]
