Message-ID: <3BF3E2D5.932B0E4B@mvista.com>
Date: Thu, 15 Nov 2001 09:44:21 -0600
From: Mark Hatle <fray@mvista.com>
MIME-Version: 1.0
To: Alda Sanomiya <sanomiya@us.ibm.com>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: Error in loading shared libraries: invalid ELF header
References: <OF31327F98.5BC0D876-ON85256B05.004B0D9F@pok.ibm.com>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


It looks to me that you are attempting to boot off of a hard disk.  One
of two things (I would guess the first):

1) Your disk partition is damaged due to an improper reboot

2) You have the wrong libc.so.6 (i.e. one for x86)

> EXT2-fs warning: mounting unchecked fs, running e2fsck is recommended
> VFS: Mounted root (ext2 filesystem).
> Freeing unused kernel memory: 176k init 4k openfirmware
> init: error in loading shared libraries: libc.so.6: invalid ELF header
> Kernel panic: Attempted to kill init!

The EXT2-fs warning message above seems to indicate the ext2 partition
is at the least not clean, at the worst corrupt.

--Mark

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
