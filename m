Date: Tue, 26 Jan 1999 17:07:22 -0500
Message-Id: <199901262207.RAA06012@wrath.iatlas.com>
From: Ira Joseph Woodhead <ira@wrath.iatlas.com>
To: linuxppc-dev@lists.linuxppc.org
CC: ira@wrath.iatlas.com
Subject: pre-R5 deficiencies
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>



Hi all,

Perhaps I'm rehashing something but I couldn't find it searching the
archives, so:

What is the reasoning behind including a findutils in pre-R5 that has no
updatedb binary?? It even has scripts that use updatedb (cron jobs) but
no updatedb binary. Furthermore, 'rpm -qlp *.rpm' reveals that it is not
included in any package.

After quite a lot of effort installing pre-R5 a couple of weeks ago I
reverted back to my creaky barely-R4 from ages ago because I was so
shocked that the most useful tool for feeling your way in a new
installation was simply not there. It gives the impression of a very
not-ready product, which is counter to the impression I get from you
folks. 

I just checked back today after a couple of weeks to find a few packages
updated on 15 Jan, but not findutils.

Just curious!

Cheers,
ira

[[ This message was sent via the linuxppc-dev mailing list. Replies are ]]
[[ not forced back to the list, so be sure to  Cc linuxppc-dev  if your ]]
[[ reply is of general interest. To unsubscribe from linuxppc-dev, send ]]
[[ the message 'unsubscribe' to linuxppc-dev-request@lists.linuxppc.org ]]
