Date: Wed, 7 Apr 1999 18:40:41 -0500 (CDT)
From: "David A. Gatwood" <marsmail@globegate.utm.edu>
To: satadru pramanik <satadru@umich.edu>
cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: Mac OS X Server Filesystem Format
In-Reply-To: <Pine.LNX.4.10.9904071556570.13483-100000@beer.pub.umich.edu>
Message-ID: <Pine.LNX.3.96.990407183923.5918B-100000@globegate.utm.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Wed, 7 Apr 1999, satadru pramanik wrote:

> has anybody tried to mount any of the Mac OS X Server CDs inside linux?
> I assume they have a BSD format... Mounting auto doesn't work with the
> CDs.   With ALL Linux filesystems enabled in the kernel, what mount
> options would I use to get the CD to mount?

I'm surprised they're not ISO-9660... but if they're really a bsd
filesystem, you'd technically be looking for ffs, but I think linux still
calls it ufs....  :-)


Later,
David

David A. Gatwood                         Visit globegate's internet
dgatwood@globegate.utm.edu                  talker, Deep Space 36
http://globegate.utm.edu                telnet globegate.utm.edu:9624


[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
