From: Tom Harrington <tph@rmi.net>
Message-Id: <199901250055.RAA20183@shell.rmi.net>
Subject: Re: Linux and Mac together (Was: Re: mac-on-linux project status)
To: robin@louis.bidmc.harvard.edu (Robin Colgrove)
Date: Sun, 24 Jan 1999 17:55:16 -0700 (MST)
Cc: linuxppc-dev@lists.linuxppc.org
In-Reply-To: <36AB7411.F40DFF97@louis.bidmc.harvard.edu> from "Robin Colgrove" at Jan 24, 99 02:28:22 pm
Content-Type: text
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


 
> Maybe I am just not understanding this but if both MkLinux and OS X run on 
> top of the Mach microkernel, could they both be running simultaneously? If 
> so, I could imagine using OS X (not OS X server) as my desktop OS while 
> on the same machine MkLinux was taking care of the internet server things 
> in the background. I do not need super high performance stuff since I 
> only "host" a few dozen pretty low-intensity users.  Right now I get by on 
> shareware tools (Quid Pro Quo, Rumor Mill, OTChat, NCSATelnet, Eudora 
> Internet Mail Server) but I am reaching the limits of what I can do with 
> these.

In principle, yes,  Mach is capable of running multiple server operating 
systems at the same time.  I have no idea what's involved in making this
happen, but supposedly one of the advantges of a microkernel-based Linux
(like MkLinux or L4Linux) is that you can run one Linux kernel while
debugging another one simultaneously.  You may have trouble, though, if
Apple is using a different version of Mach than MkLinux does, or if Apple
has stuck some MacOS X Server-specific things into their Mach code.

I really can't help you beyond suggesting that the MkLinux mailing lists
might be a better place to ask.  If you succeed, though, I'd be very
interested in hearing about it.  Good luck.  :-)

Depending on how urgent your needs are and how much MacOS you need vs. 
server stuff, you might be better off waiting for SheepShaver on Linux.


[[ This message was sent via the linuxppc-dev mailing list. Replies are ]]
[[ not forced back to the list, so be sure to  Cc linuxppc-dev  if your ]]
[[ reply is of general interest. To unsubscribe from linuxppc-dev, send ]]
[[ the message 'unsubscribe' to linuxppc-dev-request@lists.linuxppc.org ]]
