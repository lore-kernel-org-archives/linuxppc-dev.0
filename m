Message-ID: <3A8C6C98.6E5C3889@intel.com>
Date: Thu, 15 Feb 2001 15:56:08 -0800
From: "Bruno R. Barreyra" <bruno.r.barreyra@intel.com>
MIME-Version: 1.0
To: linuxppc-embedded@lists.linuxppc.org
Subject: Runtime libs
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


I've done a lot of progress with my FADS board... ppcboots automatically

determines its IP address, downloads and boots the kernel. The kernel
boots,
maps a NFS share as root.

Now I'm looking for a runtime lib. I've tried compiling both stock
glibc-2.2.1
and dietlibc, and failed miserably. What is the favored runtime lib now
for
a 823 target?

I know I can use the Montavista stuff, I'm playing with it a little bit,
but I'm
a compile freak... :)

--
[]'s Bruno Renato Barreyra
bruno.r.barreyra@ufl.edu
barreyra@ufl.edu


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
