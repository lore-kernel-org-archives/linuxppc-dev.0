Date: Thu, 4 Feb 1999 12:42:05 +1100
Message-Id: <199902040142.MAA03853@tango.anu.edu.au>
From: Paul Mackerras <paulus@cs.anu.edu.au>
To: brad@pht.com
CC: drow@false.org, linuxppc-dev@lists.linuxppc.org, geiseri@msoe.edu
In-reply-to: <Pine.LNX.3.95.990203174811.1985A-100000@pacific.pht.com>
	(message from Brad Midgley on Wed, 3 Feb 1999 17:54:38 -0700 (MST))
Subject: Re: scsi hangs [drow@cs.cmu.edu: Re: CD-writers] (fwd)
Reply-to: Paul.Mackerras@cs.anu.edu.au
References: <Pine.LNX.3.95.990203174811.1985A-100000@pacific.pht.com>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Brad Midgley <brad@pht.com> wrote:

> so... the 53c94 driver currently doesn't allow enough access to regular
> hard drives when you're using the generic device. i don't know how this
> relates to disconnect/reconnect or the scheduler. 

IIRC, the mac53c94.c driver doesn't support disconnect/reconnect.  I
presume it can but I don't know how you make it do it.

Paul.

[[ This message was sent via the linuxppc-dev mailing list. Replies are ]]
[[ not forced back to the list, so be sure to  Cc linuxppc-dev  if your ]]
[[ reply is of general interest. To unsubscribe from linuxppc-dev, send ]]
[[ the message 'unsubscribe' to linuxppc-dev-request@lists.linuxppc.org ]]
