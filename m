Date: Tue, 15 Aug 2000 16:43:52 -0700 (PDT)
From: "David A. Gatwood" <dgatwood@deepspace.mklinux.org>
To: MkLinux Setup List <mklinux-setup@public.lists.apple.com>
cc: linuxppc-dev@lists.linuxppc.org
Subject: Xlib Question
Message-ID: <Pine.LNX.3.96.1000815163648.21337B-100000@deepspace.mklinux.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


For anybody out there who is familiar with Xlib (libx11), I'm stuck on
something and I'm wondering if it's a kernel bug (in monolithic Linux).
When I'm running a multithreaded app with heavy signal load, xlib messages
stop being delivered from xlib to the program, resulting in XNextEvent
stalling.  Most of the time, if you click somewhere in that window, those
events all get delivered at once, sometimes twenty or thirty at a time.

Any ideas?


Later,
David

---------------------------------------------------------------------
A brief Haiku:

Microsoft is bad.
It seems secure at first glance.
Then you read your mail.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
