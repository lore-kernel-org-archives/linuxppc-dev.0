Cc: mark phillips <msss@ne.mediaone.net>
Message-ID: <3963473C.D493984A@lucent.com>
Date: Wed, 05 Jul 2000 09:33:32 -0500
From: Tom Roberts <tjroberts@lucent.com>
MIME-Version: 1.0
To: linuxppc-embedded@lists.linuxppc.org
Subject: Re: Problems with HardHat/NFS root filesystems
References: <39625545.370FE91F@ne.mediaone.net>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


I, too, had shared-library troubles with this.

My solution was to use the Suse PowerPC Beta distribution CDROM I
got as a door prize. I could not boot from the CDROM (no drive
on my board), but I did manually build up a disk filesystem by
starting from their initial root and then installing all of their
core RPMs on top of it. I ended up with a complete Linux system,
including gcc, gdb, etc., about 180 MB total. It works great for me.

	It is a great convenience to have the embedded board hosted
	on another Linux system which is the NFS fileserver for the
	board; they of course share all logins.

This board is a 200 MHz 750 with 64 MBytes SDRAM, so it is just a bit
bigger than most embedded systems. Now to get the other two CPUs
running....


Tom Roberts	tjroberts@lucent.com

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
