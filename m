From: Miles Lane <miles.lane@comcast.net>
To: linuxppc-dev@lists.linuxppc.org
Subject: (Reminder) Re: linuxppc-2.5 (rsync mvista) -- drivers/input/evdev.c:243: error: invalid lvalue in asm statement 
Date: Wed, 13 Aug 2003 12:57:53 -0700
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Message-Id: <200308131257.53910.miles.lane@comcast.net>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Paul Mackerras writes:

> Benjamin Herrenschmidt writes:
>
> > It's still totally wrong to access userland with a variable sized
> > data since my understanding is that userland doesn't know what size
> > the kernel will use for access here, thus it works for little endian
> > but not big endian (well... afaik).
>
> The userland data isn't variable-sized; it's an int, and it is
> accessed as an int because the pointer given to get_user is int *.
> The problem is (as Franz pointed out) the use of (a? b: c) as an
> lvalue.
>
> Incidentally there is a bug in the INPUT_KEYCODE macro: the second
> (dev->keycodesize == 1) should be == 2 instead (the condition for the
> u16 case).

This problem is still around in linuxppc-2.5.

	Miles

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
