Date: Tue, 17 Jul 2001 09:12:35 -0400
From: Armando Di Cianno <diciaa@rpi.edu>
To: linuxppc-dev@lists.linuxppc.org
Subject: 2.4.7preX - unresolved symbols/compilation problem
Message-ID: <20010717091235.G29799@garmonbozia.productivitynet.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


I figured this post would do better on the dev list than the user list,
sorry if I misinterpret the goal of both lists.

I started with an ultra-basic install of YellowDog 2.0 on my TiBook (I
wanted the glibc 2.2, and I like compiling everything else by hand).
However, now that everything is up to par, I tried compiling both the benh
and bk 2.4.7preX trees, and while they compile, upon reboot, all modules
complain about unresolved symbols, even though cat'ng System.map reveals
that those symbols are there (stuff like printk!!!).

Compiling a kernel is nothing new to me.  I place vmlinux and System.map in
my boot directly, and place according entries in my yaboot.conf, as well as
cleaning up symlinks, etc.

Does anyone know if this could be a problem with a user-space kernel
controlling utlity?  I believe I have the newest (or new-enough) mod-utils.

Becuase I did the basic install of YDL 2.0, I could be missing something.
However the included 2.4.4 sources with that distro compile and load fine.

Any suggestions would be appreciated.

__Armando Di Cianno
diciaa@rpi.edu

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
