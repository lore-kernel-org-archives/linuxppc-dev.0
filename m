Message-Id: <200105072040.f47KeI628767@stimpy.networkrobots.com>
Date: Mon, 07 May 2001 13:46:43 -0700
To: linuxppc-dev@lists.linuxppc.org
From: Paul White <pwhite@networkrobots.com>
Subject: Loadable Modules
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


All,

Does anyone have loadable modules working sucessfully on LinuxPPC v2.4.0?
Here is the problem I am seeing:

When attempting to insert a module, I will receive a floating point
exception.  However, if I force the board to
think it has 8 Meg of memory (it actually has 32 Meg), by placing "mem=8M"
on the command line, all
loadable modules work fine.  It seems as though it has something to do with
the page table stuff.

Has anyone seen this problem before?

Thanks,

Paul W.


-------------------------------------------------------------
Network Robots, Inc.         /--\               Paul H. White
                           / ____ \
4695 Chabot Dr. #200      / ( oo ) \       Software Developer
Pleasanton, CA 94588     /   ----   \             Engineering
(925) 924-8600           \   ----   /          (925) 580-4883
                          \  V--V  /
                           \      /
                             \--/

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
