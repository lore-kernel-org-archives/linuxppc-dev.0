Date: Thu, 17 Apr 2003 19:36:24 +0200
From: "K.G." <k_guillaume@libertysurf.fr>
To: linuxppc-dev@lists.linuxppc.org
Subject: Experimental HFS+ resize support and bugfix for HFS (4th patch)
Message-Id: <20030417193624.64a7954a.k_guillaume@libertysurf.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi,

Here is my last patch against parted 1.6.5, to provide HFS and HFS+ support for it :

http://xilun666.free.fr/parted-1.6.5-hfs-4.patch

It includes :
	memory leaks removal, code cleanups, resize hfs+ code,
	more checks, minor hfs resize bugfix, probe code returns real geometry,
and still all features of the third (same address, s/-4/-3/) patch.

If you want to try it you should save your important data.
You may want to run hpfsck or the Apple Sos Disk util too, before and after running parted with this patch.
Please also report me success or failure, as well as messages from fsck utils.

Enjoy !

---
Guillaume Knispel

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
