Date: Mon, 4 Jan 1999 22:38:45 +1100
Message-Id: <199901041138.WAA00533@tango.anu.edu.au>
From: Paul Mackerras <paulus@cs.anu.edu.au>
To: brad@pht.com
CC: drow@cs.cmu.edu, linuxppc-dev@lists.linuxppc.org
In-reply-to: <Pine.LNX.3.95.990103224624.29306A-100000@pacific.pht.com>
	(message from Brad Midgley on Sun, 3 Jan 1999 22:50:45 -0700 (MST))
Subject: Re: scsi hangs [drow@cs.cmu.edu: Re: CD-writers] (fwd)
Reply-to: Paul.Mackerras@cs.anu.edu.au
References: <Pine.LNX.3.95.990103224624.29306A-100000@pacific.pht.com>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Brad Midgley <brad@pht.com> wrote:

> i have tried out the current vger kernel and i'd characterize it as "five
> times" as stable. meaning i can copy 125 megabytes from a jaz on the
> external bus to a drive on the internal bus before it crashes--with
> 2.1.130 i could only copy about 25 megabytes before it crashed. the error
> when it crashes is always:

Actually, I'm not sure that the vger version had the locking exactly
right before.  The version in vger is now the same as the version
currently in the official tree, and I am moderately confident it's OK.
If you can reproduce it with that version, I really will have to dig
deeper.

We will never get the sd.c patch into the official version because it
breaks SMP machines.  I know because that's what happened on my SMP
powermac. :-)

Paul.

[[ This message was sent via the linuxppc-dev mailing list. Replies are ]]
[[ not forced back to the list, so be sure to  Cc linuxppc-dev  if your ]]
[[ reply is of general interest. To unsubscribe from linuxppc-dev, send ]]
[[ the message 'unsubscribe' to linuxppc-dev-request@lists.linuxppc.org ]]
