Date: Sat, 14 Sep 2002 21:54:24 -0800
From: Ethan Benson <erbenson@alaska.net>
To: debian-powerpc@lists.debian.org, linuxppc-dev@lists.linuxppc.org
Subject: [ANN] yaboot 1.3.7-pre1 PLEASE TEST
Message-ID: <20020915055423.GV714@plato.local.lan>
Mime-Version: 1.0
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


yes, yaboot is still maintained ;-)

Please test this prerelease version of yaboot and report any problems.

If you have been waiting to report some yaboot bug NOW is the time,
doing so right after 1.3.7 goes final will result in severe annoyance
(and will just mean you have to wait much longer to get your bug
fixed).

yaboot 1.3.7 will be purely a maintenence/bugfix release.  The 1.x codebase
is in maintenence mode, no new features or major changes will be done,
instead all development effort is going into the unstable 1.99
development branch, which will eventually lead to a 2.0 release of
yaboot (a 100% rewrite).

current changes since 1.3.6:

pre1:
	- Add German translation of yaboot-howto.
	- Small updates to yaboot-howto.
	- No longer tell people to send bugs to benh in yabootconfig(8).
	- Fix file search so IBM CHRP will work if there is more than
	  one type 0x83 partition.
	- Fix possible reiserfs symlink resolution failure.
	- Fix corner case /etc/fstab parsing failure. (Debian bug#156742).
	- Small build system modifcations (mostly to accomidate the use of
	  the arch revision control system.

1.3.7-pre1 is available at the usual place:
http://penguinppc.org/projects/yaboot/testing/1.3.7-pre/

--
Ethan Benson
http://www.alaska.net/~erbenson/

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
