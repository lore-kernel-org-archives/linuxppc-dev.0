Message-Id: <200004240616.XAA02709@pop3.ucdavis.edu>
Date: Sun, 23 Apr 2000 23:16:34 -0700
Subject: XFree 4.0 dual monitor on AGP G4
From: "W. Taylor Holliday" <wtholliday@ucdavis.edu>
To: linuxppc-dev@lists.linuxppc.org
Mime-version: 1.0
Content-type: text/plain; charset="US-ASCII"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi all,

Has anyone tried tried to use XFree86 4.0 w/a dual monitor (dual head)
configuration on an AGP G4? If so, what kernel are u using? Any
not-so-obvious configuration details? I did a build of 4.0 and got it
working on my main AGP card (it auto-detects both cards) but it crashes the
kernel (2.2.15pre3, comes w/LinuxPPC 2K) when I modify the configuration to
use both monitors. The kernel also crashes when I try to run it on the
secondary card only.

thanx
- Taylor

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
