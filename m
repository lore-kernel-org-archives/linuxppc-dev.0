Message-ID: <3AA50A43.FA070FDE@matrox.com>
Date: Tue, 06 Mar 2001 11:03:15 -0500
From: Alexandre Nikolaev <anikolae@matrox.com>
Reply-To: Alexandre.Nikolaev@matrox.com
MIME-Version: 1.0
To: linuxppc-dev@lists.linuxppc.org
Subject: who loads argc in elf binary???????
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi!

We are trying montavista kernel .4 on G4. Upon starting of ELF binary,
the r3, which should contain argc, always reads 0 (for any program). r4
is ok.
What could be the problem?
Who is responsible for loading r3?

I would really appreciate if someone can help!

Alex.

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
