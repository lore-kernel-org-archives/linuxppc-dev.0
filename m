Date: Wed, 7 Apr 1999 19:23:59 -0500 (CDT)
From: "David A. Gatwood" <marsmail@globegate.utm.edu>
To: satadru pramanik <satadru@umich.edu>
cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: Mac OS X Server Filesystem Format
In-Reply-To: <Pine.LNX.4.10.9904071947110.15881-100000@beer.pub.umich.edu>
Message-ID: <Pine.LNX.3.96.990407192237.6189A-100000@globegate.utm.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Wed, 7 Apr 1999, satadru pramanik wrote:

> Of course, Apple also calls it UFS for their filesystem.   
> I tried all the ufs mount options, to no avail.   Do they use multiple
> sessions on the cd?   Perhaps somebody could elucidate as to how one
> goes about mounting a multisession cd properly.

It's not on a _partition_ on the CD, by any chance, is it?  Does pdisk
show a partition map?  If so, it could be a bit of a pain....  We run into
trouble with that under MkLinux a lot when people misburn the hybrid CD as
ISO-9660 in a mac-style partition....  Dunno, just a thought.  :-)


Later,
David

David A. Gatwood                         Visit globegate's internet
dgatwood@globegate.utm.edu                  talker, Deep Space 36
http://globegate.utm.edu                telnet globegate.utm.edu:9624


[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
