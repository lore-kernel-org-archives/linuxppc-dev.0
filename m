Date: Sat, 13 Oct 2001 23:51:28 -0800
From: Ethan Benson <erbenson@alaska.net>
To: Debian PowerPC <debian-powerpc@lists.debian.org>,
	linuxppc-dev@lists.linuxppc.org
Subject: [ANN] yaboot-1.3.4 released
Message-ID: <20011013235128.A15428@plato.local.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


I have released yaboot 1.3.4.

It is available at:

http://penguinppc.org/projects/yaboot/
http://www.alaska.net/~erbenson/yaboot/

The main interesting change is the addition of SGI XFS filesystem
support.

This version also fixes several bugs in regards to file loading, and
network/tftp boot.

Here is the complete changelog for this version:

        * Version 1.3.4

        * ybin: Correct a verbosity message.

        * yaboot:
          - Add SGI XFS filesystem support.
          - Rewrite OpenFirmware device path parsing code.  This fixes
            many bugs and inconsistencies in yaboot's file loading.
          - Fix OpenFirmware filesystem support to automatically convert
            path separator from / to \.  CDROM authors no longer need to use
            kludges like image=\\install\\powermac\\vmlinux.
          - Fix kernel loading on some systems.
          - Allow for getting files from tftp server that does not run a
            bootpd/dhcpd.
          - Fix netboot when using the `n' key.
          - Fix a great deal of incorrect format strings which could cause
            yaboot crashes.
          - Fix all filesystems to properly return error conditions, and
            report those error conditions (instead of just saying `image not
            found').
          - Make configuration file open error consistent with other file
            open errors.
          - Add `help' command to yaboot which prints out basic usage information.
          - Add non-fatal warning when bootstrap partition has wrong type (pmac only).
          - Minor code rearrangement.
          - General cruft removal and code cleanup.

        * Makefile cleanup, make filesystems configurable.

Have fun!

--
Ethan Benson
http://www.alaska.net/~erbenson/

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
