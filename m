Return-Path: <owner-linuxppc-embedded@lists.linuxppc.org>
Message-ID: <3AA7D8A9.92476309@intel.com>
Date: Thu, 08 Mar 2001 11:08:25 -0800
From: "Bruno R. Barreyra" <bruno.r.barreyra@intel.com>
MIME-Version: 1.0
To: linuxppc-embedded@lists.linuxppc.org
Subject: make dep bug and patches
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On today's linuxppc_2_4 snapshot, doing a make dep having selected
a 8xx CPU will bomb because of an include. On arch/ppc/Makefile,
line 34, the -I../8xx_io argument should be removed. It compiles
fine without it.

Also, I was wondering if two patches would be accepted to go in
the main trunk:

1 - reactivate FADS support : I've re-hacked FADS support on my
    local tree and it works fine. Actually, I was having some problems
    with the kernel available on Area51 from Montavista, and doing
    this kernel upgrade fixed it.

2 - having an option to automatically set up the headers for PPCBoot.
    I'm sure a lot of folks would appreciate this, and it wouldn't be
    hard to automatically generate a PPCBoot image.

If I know the patches will be included, I'll most gladly write them and
send them.

--
[]'s Bruno Renato Barreyra
bruno.r.barreyra@ufl.edu
barreyra@ufl.edu


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
