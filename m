Date: Thu, 26 Apr 2001 15:16:22 -0400
From: thewalthamgroup@netscape.net (Mark Phillips)
To: linuxppc-embedded@lists.linuxppc.org
Subject: interrupting gdbserver
Mime-Version: 1.0
Message-ID: <213D16B5.5C0CB2FB.C7F6CBA8@netscape.net>
Content-Type: text/plain; charset="us-ascii"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi all,

I have a workaround for a problem I've been having with gdbserver, which I thought might be of general interest.

I have not been able to get gdbserver to successfully interrupt a running program, although I believe it is supposed to be able to do that.  As a result, if you set a breakpoint in the wrong location (or your program gets stuck somewhere you didn't expect), you lose control of it.

However, there is a workaround, assuming you have a console on your remote target.  Just do a "kill -SIGSTOP <pid>", where <pid> is the process-id of the Application (not the gdbserver that spawned it!).  This wakes up the whole chain, and you're back in control.

I hope this technique is of use to someone, although I gather most of you don't find it necessary (and the rest probably find it obvious).

Sincerely,
Mark Phillips

--
Please reply to markphillips@alum.mit.edu

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
