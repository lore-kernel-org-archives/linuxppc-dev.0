Subject: Re: 64-bit user-space on G5? Never, soonish, or unknown?
From: Albert Cahalan <albert@users.sourceforge.net>
To: linuxppc-dev@lists.linuxppc.org
Cc: benh@kernel.crashing.org
Content-Type: text/plain
Message-Id: <1078010187.2233.105.camel@cube>
Mime-Version: 1.0
Date: 28 Feb 2004 18:16:28 -0500
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Benjamin Herrenschmidt writes:

> The 64 bits kernel allow you to run both 32 and
> 64 bits userland, the common practice is to have
> a 32 bit userland with the necessary libs to be
> able to build & run _some_ 64 bits executables.

You'd better have a 64-bit ncurses. If you don't,
your procps will be compiled incorrectly. Data
will get truncated, mangled, etc. -- assuming you
can even run the tools at all.

The same goes for pretty much any other lib.
If it isn't a package-private lib, you need
it in a 64-bit version. The 32-bit libs can
go in an optional compatibility package.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
