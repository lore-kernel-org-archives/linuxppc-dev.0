Date: Tue, 22 Dec 1998 14:59:42 -0700 (MST)
From: john s jacobs anderson <jacobs@azstarnet.com>
To: Tom Harrington <tph@rmi.net>
cc: linuxppc-user@lists.linuxppc.org, linuxppc-dev@lists.linuxppc.org
Subject: Re: TurboMouse fix
In-Reply-To: <m0zsV1o-001C7HC@shell.rmi.net>
Message-ID: <Pine.LNX.3.96.981222145001.10207B-100000@lazarus>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


> Hmm, maybe something in your header files?  ADB_WRITEREG is defined (on
> my system) in /usr/include/asm/adb_mouse.h.  Look for this file and see 
> what's there.

OMM, the /usr/include/asm dir is a symlink to asm-ppc in the kernel
source, which is 2.1.131. That file contains a struct def for
mouse_status, and that's all. The ADB_WRITEREG, etc. #defines are in
adb.h.

> I'm surprised it complains about "ADB-WRITEREG" when the code uses
> "ADB_WRITEREG".  You didn't happen to "fix" this while trimming the
> file in pico, did you?

No, I screwed up while re-typing the error messages into my email.
Nothing in between the --cut here-- and --cut here-- (or whatever you
had delimiting the code) was changed. 

(Is it just me, or is everybody assuming I'm way more stupid than is
necessary? I followed instructions, and when that didn't work, I provided
the requested feedback, and so far I've got two condescending emails to
show for it.) 

> I really don't know if mousehack is useful (or even necessary) with a v4.0
> TurboMouse.  I assume you've tried the "mousemode" command?

Well, Mark Abene(sp?) has said in this thread that mousehack doesn't work
with the 4.0 balls. I've tried mousemode; the mouse just switches back.

Maybe it's time to start shopping for one of the 5.0 turbo mice -- too
bad, the design and construction seems a lot more solid on the 4.0 models.

john.
jacobs@treefort.org
www.treefort.org/~jacobs



[[ This message was sent via the linuxppc-dev mailing list. Replies are ]]
[[ not forced back to the list, so be sure to  Cc linuxppc-dev  if your ]]
[[ reply is of general interest. To unsubscribe from linuxppc-dev, send ]]
[[ the message 'unsubscribe' to linuxppc-dev-request@lists.linuxppc.org ]]
