Date: Sat, 11 Dec 1999 19:00:15 -0500 (EST)
From: Claude Robitaille <crobitaille@videotron.ca>
Subject: Thread and malloc
In-reply-to: <38172075.EC2839C2@netx4.com>
To: linuxppc-dev@lists.linuxppc.org
Message-id: <Pine.LNX.4.10.9912111854110.20354-100000@localhost.localdomain>
MIME-version: 1.0
Content-type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi,

I am getting segmentation faults in malloc when using threads. I have
updated my kernel to 2.2.14pre6, gcc, gdb (to 4.18), etc. I try both
code_medic and ddd. Is malloc thread safe? A book I am reading indicates
that some malloc are thread safe and some others are not. But the book
is not Linux specific.

The Web pages I have found so far are pretty old and mostly talk about
LinuxThread (for 2.0.X). The man pages for malloc, etc. do not indicate
anything about thread friendlyness... (and they would probably out of date
anyway....). Is there a good place for information about thread in Linux?
Anyboady has a idea why I an getting faults in malloc?

Thanks

Claude


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
