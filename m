Message-ID: <3686B22B.69BA@post.uni-bielefeld.de>
Date: Sun, 27 Dec 1998 23:18:22 +0100
From: "Jens Ch. Restemeier" <jenschrr@post.uni-bielefeld.de>
Reply-To: jenschrr@post.uni-bielefeld.de
MIME-Version: 1.0
To: linuxppc-dev@lists.linuxppc.org
Subject: via-cuda crashing ?
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi !

Nobody had any documentation on via-cuda, so I started some experiments
by myself. After a lot of reboots I found that after sending an
incomplete I2C request
- via cuda polling doesn't return
- if I use a timeout and send the next command anyway I get a
kernel-panic.

Is there any way to tell cuda: "Whatever you do, stop it and return to
normal operation" ?

I need this to implement I2C bus scanning.

Jens

[[ This message was sent via the linuxppc-dev mailing list. Replies are ]]
[[ not forced back to the list, so be sure to  Cc linuxppc-dev  if your ]]
[[ reply is of general interest. To unsubscribe from linuxppc-dev, send ]]
[[ the message 'unsubscribe' to linuxppc-dev-request@lists.linuxppc.org ]]
