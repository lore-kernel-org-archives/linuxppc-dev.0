Content-Type: text/plain;
  charset="iso-8859-1"
From: Brian Waite <waite@skycomputers.com>
To: Dan Malek <dan@embeddededge.com>
Subject: Re: NFS root woes: No init found
Date: Wed, 4 Dec 2002 17:11:04 -0500
Cc: linuxppc-embedded@lists.linuxppc.org
References: <200212041635.31861.waite@skycomputers.com> <3DEE781C.5070208@embeddededge.com>
In-Reply-To: <3DEE781C.5070208@embeddededge.com>
MIME-Version: 1.0
Message-Id: <200212041711.04032.waite@skycomputers.com>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


I did this. I tried to start a staticly linked ash shell to no avail. No libs
are better than any libs :)
Thanks
Brian
On Wednesday 04 December 2002 4:48 pm, Dan Malek wrote:
> Brian Waite wrote:
> > ...Then I get the message No init found.
>
> First, try using something simple like /bin/bash as your init program.
> Trying to start up the init program relies on lots of things being
> present in the file system.  If the program starts, and then exits,
> you still get this message.
>
> Just use a trivial, simple file system to get started.  A shell,
> couple of commands and minimal libraries are easier to debug.
>
> Good luck :-)
>
> 	-- Dan


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
