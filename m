Date: Thu, 17 Jun 1999 14:36:00 -0400 (EDT)
From: satadru pramanik <satadru@umich.edu>
To: Inter Nut <internut@sie.com>
cc: netatalk-admins@umich.edu, linuxppc-dev@lists.linuxppc.org
Subject: Re: [netatalk-admins] help!
In-Reply-To: <v04020a03b38ec4f2301e@[192.168.0.5]>
Message-ID: <Pine.LNX.4.10.9906171434460.24433-100000@beer.pub.umich.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


This is exactly the problem I had when i moved from vger linux kernel
2.2.7 to 2.2.10.   Moving back to 2.2.7 makes the problem go away
completely.


On Thu, 17 Jun 1999, Inter Nut wrote:

Hi,
I'm running an AMD 350 Mhz box with 64 megs ram and 2 internal UDMA hds
(22gig & 14 gigs)  partitioned into 5 partitions (4  8gig partitions, 64
meg swap, and  the remainder as a temp.)  Running Redhat Linux 5.2.   The
NIC is a 3com 10/100 base T pci card.

Everything works great - including Xwindows.

I want to make this box a Linux Appletalk & NT file server.  So I installed
the latest netatalk RPMs from the redhat and/or
http://thehamptons.com/anders/netatalk/  sites as well as Samba.

The network consists of 8 powermacs running  systems 8.5-8.6  as well as a
couple of pcs running NT 4.0 and 98.  At present there is a mac 8100
running as a file server - but it's a DOG.  Figure it's time to go linux,
huh?

OK - now the fun part.

I can telnet and ftp into the linux box with no problem.  My pcs running
maclan see the linux box in the network neighborhood.  The macs all see the
linux box in the chooser/network browser.   BUT....

When I try to connect to the linux box from the macs - I get a  " (I/O
error ) - "-1072"   "  or a  " connection to the specified server has been
unexpectedly broken "  message and it won't let me in.  Likewise -  I
cannot log in via the pc either due to  "An Appletealk errer has occured"
message.

I set up 3 users and made sure their passwords conform to the proper
conventions (no I didn't try to log in as root).    Is there something
special I need to do to these users other than run the following commands:?
adduser  USERNAME
passwd USERNAME

What else can it be?

Thanx a lot for any help.




----
satadru pramanik `satadru@umich.edu'
"Put your hand on a hot stove for a minute, and it seems like an hour. Sit
with a pretty girl for an hour, and it seems like a minute. THAT'S
relativity." 
-Albert Einstein
---


[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
