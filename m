Return-Path: <owner-linuxppc-embedded@lists.linuxppc.org>
Message-ID: <3A9315B8.16C9BF1@intel.com>
Date: Tue, 20 Feb 2001 17:11:20 -0800
From: "Bruno R. Barreyra" <bruno.r.barreyra@intel.com>
MIME-Version: 1.0
To: linuxppc-embedded@lists.linuxppc.org
Subject: init on a FADS823
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


I'm trying to get a init program to work on my FADS823.

Running bash as the init process works fine. However, if I try the
sysvinit from Montavista, it
just asks me for a runlevel and then says there are no processes left on
that runlevel. I'm
trying to compile simpleinit from util-linux, since I need a really
simple solution, but it won't
work either. It says "init: stat of path failed". Any ideas?

On a separate note, I also need to get smbmount working, but
cross-compiling the samba
package seems impossible. Has anybody done it?

--
[]'s Bruno Renato Barreyra
bruno.r.barreyra@ufl.edu
barreyra@ufl.edu


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
