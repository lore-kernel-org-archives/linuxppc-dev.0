Date: Tue, 20 Apr 1999 14:52:01 -0500 (CDT)
From: "David A. Gatwood" <marsmail@globegate.utm.edu>
To: Geert Uytterhoeven <Geert.Uytterhoeven@cs.kuleuven.ac.be>
cc: root <roboj@ibm.net>, linuxppc-dev@lists.linuxppc.org
Subject: Re: Kernel 2.2.6-ac1 problem
In-Reply-To: <Pine.LNX.4.10.9904201946220.31451-100000@mercator.cs.kuleuven.ac.be>
Message-ID: <Pine.LNX.3.96.990420144859.24907A-100000@globegate.utm.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Tue, 20 Apr 1999, Geert Uytterhoeven wrote:

> > We've had similar problems with free block corruption under MkLinux
> > (2.0.37).  This may be a red herring, but I've only noticed the damage on
> > the last partition mounted.  You might try mounting a bogus partition
> > after the others and see if it goes away.  Just a wild thought.  Anyway,
> > the problem began when someone ported some changes from the current
> > development sources into the 2.0.xx tree, between 2.0.33 and 2.0.36 (the
> > former was fine, the latter has the problem.  It might be easier to find
> > in the context of 2.0.xx since many less things were changing....
> 
> Do you mean the change from big endian ext2fs to standard little endian
> ext2fs?

No.  I've been running little endian with linux servers running back to
2.0.28 or so, or shortly thereafter.  2.0.33 is stock DR3, MkLinux's
current branch is 2.0.37 pre-patch whatever....

The related code I noticed changing was related to quota support.  It
doesn't appear to be in the ext2fs code changes, though, because I tried
backdating all of those (other than simple formatting and notational
changes0 to no avail.  I'm thinking it might be in the general filesystem
code.


Later,
David

David A. Gatwood                         Visit globegate's internet
dgatwood@globegate.utm.edu                  talker, Deep Space 36
http://globegate.utm.edu                telnet globegate.utm.edu:9624


[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
