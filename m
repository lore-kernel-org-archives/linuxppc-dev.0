Date: Wed, 13 Jan 1999 16:03:39 -0800 (PST)
From: Ryan Mack <mackman@alz.com>
To: linuxppc-dev@lists.linuxppc.org
cc: mackman@alz.com
Subject: Interrupt Key Support?
Message-ID: <Pine.LNX.4.05.9901131559160.596-100000@mackman.caltech.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Having been recently frustrated with the lock ups of the accellerated
FBDev X server, I've been thinking about alternative ways to rebooting my
system. GPM doesn't work when the hardware crashes, and telnetting from
another machine is a hassle. I was curious what possiblity there would be
to implement kernel-level or daemon-level support for the "Interrupt" key
present on most PowerMacs and PowerBooks. It seems if this could fuction
as a soft-reboot command (or any other cofigurable command) it would save
a lot of frustration of hard-rebooting in a networkless enviroment or save
time anywhere else. Just a though, I know too little about ppc hardware to
judge how hard it would be. Thanks.

-Ryan Mack


[[ This message was sent via the linuxppc-dev mailing list. Replies are ]]
[[ not forced back to the list, so be sure to  Cc linuxppc-dev  if your ]]
[[ reply is of general interest. To unsubscribe from linuxppc-dev, send ]]
[[ the message 'unsubscribe' to linuxppc-dev-request@lists.linuxppc.org ]]
