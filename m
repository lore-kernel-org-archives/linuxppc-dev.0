Subject: HFS+ kernel module
To: linuxppc-dev@lists.linuxppc.org
Date: Sat, 30 Sep 2000 19:34:44 -0700 (PDT)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-Id: <20001001023444.804932B54A@marcus.pants.nu>
From: flar@pants.nu (Brad Boyer)
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


I finally fixed enough bugs in my hfsplus module that it almost
works. It isn't ready for regular users, tho. It has a tendency
to crash, although I must admit that I only had it crash once,
and only on umount. It also does a very bad job of handling
non-ASCII characters, and it doesn't do anything to / characters,
so you may get some strange listings and files that show up in
the listing but aren't accessible. It's still fairly verbose with
debugging output, although it's drastically trimmed down from
what was there.

I'd appreciate it if some daring people try it out, and if it
crashes, please give me the function it crashed in if possible.
If anyone knows unicode fairly well, and is willing to help
fix the problems with the unicode conversion, I'd really
appreciate it, because it's currently very broken for anything
other than ASCII.

You can find the patch in my directory on devel.linuxppc.org.

http://devel.linuxppc.org/pub/users/flar/

It is a patch against 2.2.14, but it applies to 2.2.17 and
should apply to almost any 2.2.x kernel.

	Brad Boyer
	flar@allandria.com


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
