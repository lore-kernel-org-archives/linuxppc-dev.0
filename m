Date: Sat, 15 Jan 2000 23:12:05 -0800 (PST)
From: Sean Chitwood <darkmane@w-link.net>
Reply-To: darkmane@w-link.net
To: LinuxPPC Developers List <linuxppc-dev@lists.linuxppc.org>
Subject: Help w/ gdb
In-Reply-To: <Pine.LNX.4.10.10001151429520.17643-100000@newhope.terraplex.com>
Message-ID: <Pine.LNX.4.10.10001152247220.28099-100000@darkmane.w-link.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi-
	I periodically ask this question here because I have never found a more appropriate audience or satisfactory answer.

	I am attempting to help w/ the mozilla project, but I am having little success due to the following problem. When I attempt to debug an assert/crash as I bring up the stack trace I notice that some of the frames point only to the ending curly brace of a function (Not always the one it says is being debugged). I cannot examine variables, or learn anything else productive about the situation. I realize I am not familiar w/ gdb, I am primarily familiar w/ windows GUI based debuggers, so I figure I am missing a configuration setting, but for the life of me I can't figure out what it is. I do know that I am keeping the source and binary files synced, so that shouldn't be it. It seems to load the symbols correctly (no complaining about missing symbols), butother than that I seem to be clueless.

	I am enclosing my .gdbinit file (it is short) so you can see if anything is missing. I am using gdb-4.18-4c, which I believe I got from fsirl's directory on devel.linuxppc.org.

	So please could you help?

	Sean aka Darkmane
+------------------------------
+ On October 16, 1999 A.D.
+ Sean Chitwood proudly proclaimed
+ his love for Melissa Webb
+ and made her his lifemate
+------------------------------

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
