From: "Navin Boppuri" <nboppuri@myiagent.com>
To: <linuxppc-embedded@lists.linuxppc.org>
Subject: zImage.initrd problems
Date: Tue, 1 Aug 2000 21:22:12 -0500
Message-ID: <NEBBLLEGJMLHPJEFEOKPEEILCAAA.nboppuri@myiagent.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hello everyone,

I am running a FADS board with an 823 processor. I have been successful in
booting the kernel and mounting an NFS file system. I have also been
successful in burning the kernel into the flash and boot. I am now trying to
burn the zImage.initrd (kernel and file system) into the flash and make it
work. I am able to burn the flash with the zImage.initrd but when I try
copying the same into ram, it breaks after loading 510000 something bytes.
This happens even after changing the ram start location from 0x200000 to
0x100000. I just want to be able to copy the whole image into ram and jump
start to the start. It works fine only for the kernel but fails with a file
system.

Any suggestions?

Thank you,
Navin


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
