Date: Thu, 11 Mar 1999 15:00:36 +1100
Message-Id: <199903110400.PAA13354@tango.anu.edu.au>
From: Paul Mackerras <paulus@cs.anu.edu.au>
To: ssartor@eclipse.net
CC: linuxppc-dev@lists.linuxppc.org
In-reply-to: <199903110241.VAA03544@mail.eclipse.net> (message from Steven
	Sartorius on Wed, 10 Mar 1999 21:41:41 -0500 (EST))
Subject: Re: No-IDE kernel compile link errors
Reply-to: Paul.Mackerras@cs.anu.edu.au
References: <199903110241.VAA03544@mail.eclipse.net>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Steven Sartorius <ssartor@eclipse.net> wrote:

> I've had the same problem.  The only way I could get rid of all
> traces of IDE was to run 'make config' and tediously step through
> each kernel option.  A pain but it worked.

A useful trick if you just want to change one kernel option is to edit
your .config to delete that particular line, then say `make oldconfig'.
It will run through and just ask you about the option you deleted.
(Don't just change the line to what you want, because make config does
several other things like setting up autoconf.h and include/config.)

Paul.

[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
