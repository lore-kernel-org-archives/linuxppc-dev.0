Date: Thu, 14 Jan 1999 00:02:15 -0500 (EST)
From: satadru pramanik <satadru@umich.edu>
To: Ryan Mack <mackman@alz.com>
cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: Interrupt Key Support?
In-Reply-To: <Pine.LNX.4.05.9901131559160.596-100000@mackman.caltech.edu>
Message-ID: <Pine.LNX.4.05.9901140001420.17204-100000@beer.pub.umich.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


The equiv of cntrl-alt-del works.
either cntrl option del, or maybe cntrl command del.


On Wed, 13 Jan 1999, Ryan Mack wrote:


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




----
satadru pramanik `satadru@umich.edu'
"Put your hand on a hot stove for a minute, and it seems like an hour. Sit
with a pretty girl for an hour, and it seems like a minute. THAT'S
relativity." 
-Albert Einstein
---


[[ This message was sent via the linuxppc-dev mailing list. Replies are ]]
[[ not forced back to the list, so be sure to  Cc linuxppc-dev  if your ]]
[[ reply is of general interest. To unsubscribe from linuxppc-dev, send ]]
[[ the message 'unsubscribe' to linuxppc-dev-request@lists.linuxppc.org ]]
