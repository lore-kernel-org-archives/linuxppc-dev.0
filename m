Return-Path: <owner-linuxppc-dev@lists.linuxppc.org>
From: phandel@cise.ufl.edu
Date: Sat, 21 Oct 2000 00:36:58 -0700 (PDT)
Subject: Re: 2.4.0-test10 & iMac video failure
In-reply-to: <20001021060725.8637.qmail@kunk.jriver.com>
To: Robert E Brose II <bob@kunk.jriver.com>
Cc: linuxppc-dev@lists.linuxppc.org
Message-id: <Pine.LNX.4.21.0010210035180.1807-100000@like.mine.nu>
MIME-version: 1.0
Content-type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Sat, 21 Oct 2000, Robert E Brose II wrote:

> If I build a kernel from the penguinppc dev tree (as of 10-21) and use
> bootx 1.2 for booting, it will not bring up the iMac rev C mach64
> properly.

Make sure you don't have "xmon" (under Kernel Debugging) selected.  -test9
worked fine with it on, but I'm seeing some problems with it in -test10.


Thanks,
Peter


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
