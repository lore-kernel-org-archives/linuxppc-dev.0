Date: Mon, 1 Feb 1999 15:53:25 -0800 (PST)
From: Eric Guenterberg <mavpion@fire.csua.ucla.edu>
To: linuxppc-dev@lists.linuxppc.org
cc: Eric Guenterberg <mavpion@fire.csua.ucla.edu>
Subject: Linux 2.2.1 Kernel scsi troubles
Message-ID: <Pine.LNX.3.96.990201154257.111F-100000@fire.csua.ucla.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


I recently compiled the the Linux 2.2.1 kernel, but I can't get it to boot
because when it is booting it aborts the reading of the harddrive that
contains my root partition.

I have a PowerMac 7600/132

I have two internal scsi devices and one external scsi device. The
internal ones are a Quantum Fireball with scsi id 0, and a CD Rom drive
with scsi id 3. I also have an external Jaz drive with id 4. (it is on the
other scsi chain) 

Here is what happens:

It detects two scsi chains (it may call them hosts). One is MESH, the
other is that weird numbered one. At any rate, they correspond to the
internal and external scsi stuff.

It says:
scsi host 0 aborted

(or maybe it's "scsi device 0"). It recognizes the other two devices just
fine, though. 

This also happens with the precompiled 2.2.0pre-2 on linuxppc's ftp site.
The only recent kernel (ie kernel that can be booted with bootx) that has
worked for me is a precompiled 2.1.131 kernel. 

I have tried compiling the kernel with the maximum scsi reset time (20s),
and with asynchronous transfer only, and none of it works.

Any suggestions, patches, etc?

--Eric Guenterberg


[[ This message was sent via the linuxppc-dev mailing list. Replies are ]]
[[ not forced back to the list, so be sure to  Cc linuxppc-dev  if your ]]
[[ reply is of general interest. To unsubscribe from linuxppc-dev, send ]]
[[ the message 'unsubscribe' to linuxppc-dev-request@lists.linuxppc.org ]]
