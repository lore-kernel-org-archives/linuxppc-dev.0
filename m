Date: Tue, 16 Mar 1999 23:03:55 -0600 (CST)
From: nathan ingersoll <ningerso@d.umn.edu>
To: Tom Dilling <tdilling@oncodev.isc-net.upenn.edu>
cc: linuxppc-dev@lists.linuxppc.org, linuxppc-user@lists.linuxppc.org
Subject: Re: anon-CVS: HOW?
In-Reply-To: <199903170133.UAA09391@oncodev.isc-net.upenn.edu>
Message-ID: <Pine.SO4.4.02.9903162249200.13731-100000@ub.d.umn.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Sure, the directions on the web page for the cvs server seem to be 
incorrect, so I could see why you'd have problems.

First, take a look at the web site:

	http://cvs.on.openprojects.net

The basic instructions are listed there. For those who don't want to look
they basically go like this:

	1.) export CVSROOT=':pserver:anonymous@cvs.on.openprojects.net:/cvs/linux'

	2.) cvs login

		Just hit return for a password.

	3.) cvs -z3 checkout linux

		The web page says "kernel" instead of "linux", but that
		didn't work for me and I remembered that vger used linux.
		The "-z3" isn't necessary, but it speeds up transfer.

That should set up a directory in your current directory called linux and
will begin to download the source.
To update cd to the directory and type:

	cvs update -d

I think that should do it. Anyone else feel free to correct anything I may
have missed or didn't explain clearly.

Nathan


On Tue, 16 Mar 1999, Tom Dilling wrote:

> 
> Could someone write down some instructions step-by-step?  I am having
> trouble accessing the new cvs repository.
> 
> Thanks!
> 
> Sincerely,
> Tom Dilling
> Production Editor, OncoLink
> http://www.oncolink.upenn.edu/
> tdilling@oncodev.isc-net.upenn.edu
> 
> [[ This message was sent via the linuxppc-user mailing list. Replies are ]]
> [[ not forced back to the list, so be sure to  Cc linuxppc-user  if your ]]
> [[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
> [[ and http://www.linuxppc.org/ for useful information before posting.   ]]
> 


[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
