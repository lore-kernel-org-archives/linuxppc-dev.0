Message-Id: <199911201327.OAA17266@appel.flower>
To: linuxppc-dev@lists.linuxppc.org
cc: dgatwood@deepspace.mklinux.org, dorland@lords.com, hollis+@andrew.cmu.edu
Subject: Re: Floppy problems
Date: Sat, 20 Nov 1999 14:27:22 +0100
From: Jan Nieuwenhuizen <janneke@gnu.org>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>



On Sat, 20 Nov 1999 David A. Gatwood writes:

> It is very weird. Again, other G3 users, does your floppy drive work?

No, mine doesn't work either.  I've reported and asked several times here,
but never got replies (other than: use gdb.. duh)

See, eg,

	 * To: linuxppc-dev@lists.linuxppc.org
	 * Subject: /dev/fd0 close () hangs -- how to debug?
	 * From: Jan Nieuwenhuizen <janneke@gnu.org>
	 * Date: Tue, 16 Nov 1999 12:14:57 +0100
	 _________________________________________________________________


    Hi,

    I've never gotten my floppy drive to work under Linuxppc, it works fine
    under MacOS.  When accessing the floppy, it sounds ok, but the close ()
    system call doesn't return.  After this, the fd0 device can't be accessed
    again because it's busy.  The process can't be killed.

    [...]


Greetings,
Jan.

-- 
Jan Nieuwenhuizen <janneke@gnu.org> | GNU LilyPond - The music typesetter
http://www.xs4all.nl/~jantien/      | http://www.lilypond.org/

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
