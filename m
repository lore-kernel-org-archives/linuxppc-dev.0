Message-Id: <9812280419.AA35728@marc.watson.ibm.com>
To: jenschrr@post.uni-bielefeld.de
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: egcs bug - who can I send it to ? 
In-Reply-To: Message from "Jens Ch. Restemeier" <jenschrr@post.uni-bielefeld.de>
   of "Sun, 27 Dec 1998 21:29:46 +0100." <368698BA.3C54@post.uni-bielefeld.de>
Date: Sun, 27 Dec 1998 23:19:47 -0500
From: David Edelsohn <dje@watson.ibm.com>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


>>>>> "Jens Ch Restemeier" writes:

Jens> Whoops, it's egcs-2.91.57. Does this help ?

	I believe that egcs-1.1.1 reports itself as egcs-2.91.60:

		gcc version egcs-2.91.60 19981201 (egcs-1.1.1 release)

There was a PowerPC address generation bug which was fixed just before
egcs-1.1.1 was released and it might address your problem.  There is no
way for me to advise about developer interim snapshots.

David

[[ This message was sent via the linuxppc-dev mailing list. Replies are ]]
[[ not forced back to the list, so be sure to  Cc linuxppc-dev  if your ]]
[[ reply is of general interest. To unsubscribe from linuxppc-dev, send ]]
[[ the message 'unsubscribe' to linuxppc-dev-request@lists.linuxppc.org ]]
