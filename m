Message-Id: <199901071520.RAA12440@kalahari.s2.org>
To: Benjamin Herrenschmidt <bh40@calva.net>
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: [ANN] New test kernel available 
In-Reply-To: Your message of "Wed, 06 Jan 1999 19:38:13 +0100."
             <19990106193813.032518@mail.mipsys.com>
Date: Thu, 07 Jan 1999 17:20:05 +0200
From: Jarno Paananen <jpaana@s2.org>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi,

> - Sets the correct value in the IDE controller to enable full speed of IDE
>   transfer on heathrow-based machines.

Nice one-liner ;)

Transfer speed on my G3 PMac reported by hdparm -t went from 0.9Mb/s to
9.7Mb/s ;)  My P2/450 still is a bit better (13.7Mb/s) but this is what
it should be. Thanks!

// Jarno

[[ This message was sent via the linuxppc-dev mailing list. Replies are ]]
[[ not forced back to the list, so be sure to  Cc linuxppc-dev  if your ]]
[[ reply is of general interest. To unsubscribe from linuxppc-dev, send ]]
[[ the message 'unsubscribe' to linuxppc-dev-request@lists.linuxppc.org ]]
