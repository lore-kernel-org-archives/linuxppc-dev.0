Date: Sun, 21 Feb 1999 10:48:54 +1100 (EST)
From: Nathan Hurst <njh@drongo.anu.edu.au>
To: Steven Bytnar <s-bytnar@uiuc.edu>
cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: PPC Privileged mode
In-Reply-To: <v04103d00b2f3c9868068@[208.150.38.73]>
Message-ID: <Pine.LNX.3.95.990221104817.7708A-100000@drongo.anu.edu.au>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Fri, 19 Feb 1999, Steven Bytnar wrote:

> 
> How do I exit cleanly from PPC supervisor mode to MacOS? I am trying 
> to work with the code in BootX, but it was meant to execute the 
> kernel and never return. My purpose is only to read and write to 
> supervisor read/writable registers on the chip without destroying 
> MacOS.

Can't you either just set the CPU back to user mode, or return from
interupt? 

njh


[[ This message was sent via the linuxppc-dev mailing list. Replies are ]]
[[ not forced back to the list, so be sure to  Cc linuxppc-dev  if your ]]
[[ reply is of general interest. To unsubscribe from linuxppc-dev, send ]]
[[ the message 'unsubscribe' to linuxppc-dev-request@lists.linuxppc.org ]]
