Date: Thu, 24 Dec 1998 13:01:30 -0600 (CST)
From: Troy Benjegerdes <hozer@drgw.net>
To: Bryan Christianson <bryanc@ihug.co.nz>
cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: egcs 1.1.1 and outl
In-Reply-To: <l03130300b2a6e21c2a5d@[172.16.10.14]>
Message-ID: <Pine.LNX.4.04.9812241255360.28200-100000@narn.local.drgw.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Thu, 24 Dec 1998, Bryan Christianson wrote:

> 
> I am running Kernel 2.0.130 compiled with egcs 1.0.2. I upgraded the
> compiler to egcs 1.1.1 and recompiled the driver I'm working on. The driver
> crashed the machine on its first call to outl with amessage saying
> something like 'invalid msr' and then a dump of all the registers.
> 
> I've reverted back to egcs 1.0.2 and the driver works fine.

what does gcc --version say?

I'm using egcs-2.91.58, and I'm having problems with booting... I'm still
trying to figure out what the problem is.

> 
> Is this a known issue - couldn't find anything in the FAQ.
> 
> I can reproduce it and get more detail if required. I presume this is a
> problem with the compiler unless there is something weird with the code for
> outl in <io.h>
> 

Can you get a dump of the registers via a serial console? (or copy them by
hand) and send it to the list?

> --
> Bryan Christianson
> email:		<mailto:bryanc@ihug.co.nz>
> Home Page:	<http://crash.ihug.co.nz/~bryanc>
> 
> 
> 
> 

--------------------------------------------------------------------------
| Troy Benjegerdes    |       troy@microux.com     |    hozer@drgw.net   |
|    Unix is user friendly... You just have to be friendly to it first.  |
| This message composed with 100% free software.    http://www.gnu.org   |
--------------------------------------------------------------------------


[[ This message was sent via the linuxppc-dev mailing list. Replies are ]]
[[ not forced back to the list, so be sure to  Cc linuxppc-dev  if your ]]
[[ reply is of general interest. To unsubscribe from linuxppc-dev, send ]]
[[ the message 'unsubscribe' to linuxppc-dev-request@lists.linuxppc.org ]]
