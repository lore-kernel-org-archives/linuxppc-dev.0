Date: Mon, 06 Dec 1999 21:58:45 -0500 (EST)
From: Claude Robitaille <crobitaille@videotron.ca>
Subject: Debugging with thread(s)
In-reply-to: <38172075.EC2839C2@netx4.com>
To: linuxppc-dev@lists.linuxppc.org
Message-id: <Pine.LNX.4.10.9912062143190.1956-100000@localhost.localdomain>
MIME-version: 1.0
Content-type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi,

anybody has tried to debug an application that uses thread
using GUI frontend to gdb? I have try code_medic and kdbg
but in both cases, when I execute pthread_create I get an
unknown signal and the breakpoints I set in the called
(created) thread do not activate. I might have problem
with my code but I tried to put a while(1); right after
a printf just at the beginning of the created thread. I
put a breakpoint on the printf but I do get an ouput
in the program output window. (I also put a while(1);
in the calling code, just to make sure). I think, somehow,
the GUIs do not support threads. Any idea?

Claude


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
