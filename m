Date: Sun, 21 Feb 1999 22:20:16 +1100
Message-Id: <199902211120.WAA01557@tango.anu.edu.au>
From: Paul Mackerras <paulus@cs.anu.edu.au>
To: meissner@cygnus.com
CC: zankel@tarantel.rz.fh-muenchen.de, bh40@calva.net, davidsen@prodigy.com,
        cort@persephone.cs.nmt.edu, marsmail@globegate.utm.edu,
        dvdoug@tiac.net, paubert@iram.es, jskov@cygnus.co.uk, hozer@drgw.net,
        linuxppc-dev@lists.linuxppc.org
In-reply-to: <19990219085444.A1362@wogglebug.cygnus.com> (message from Michael
	Meissner on Fri, 19 Feb 1999 08:54:44 -0500)
Subject: Re: [ppc-dev] Summary: Restructuring Efforts
Reply-to: Paul.Mackerras@cs.anu.edu.au
References: <36CCB670.CE42A873@mailserv.rz.fh-muenchen.de> <199902190612.RAA00610@tango.anu.edu.au> <19990219085444.A1362@wogglebug.cygnus.com>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Michael Meissner <meissner@cygnus.com> wrote:

> Why do people keep mentioning a second tree, and not using something like a
> branch off of the main cvs tree?  Within egcs, we use branches for separate
> development tasks (1.1.x and mainline).  In fact right now, I have my own
> branch for the PowrerPC compiler changes.

Two reasons, the main one being access control, the secondary one
being that we may want to have the two trees maintained by different
people in different places.

I don't think having two trees, keeping track of the differences, and
merging changes from one to another is a big problem.  I have this
Tk-based tool called `dirdiff' for visualizing the differences between
up to 5 trees.  If anyone wants to have a look at it, it's in
ftp://samba.anu.edu.au/pub/linux-pmac/misc/dirdiff.  It's still a
little rough around the edges and it doesn't have any documentation,
but it may be useful.

Paul.

[[ This message was sent via the linuxppc-dev mailing list. Replies are ]]
[[ not forced back to the list, so be sure to  Cc linuxppc-dev  if your ]]
[[ reply is of general interest. To unsubscribe from linuxppc-dev, send ]]
[[ the message 'unsubscribe' to linuxppc-dev-request@lists.linuxppc.org ]]
