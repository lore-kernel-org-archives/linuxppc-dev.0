Date: Thu, 22 Nov 2001 00:30:12 -0900
From: Ethan Benson <erbenson@alaska.net>
To: linuxppc-dev@lists.linuxppc.org
Subject: [ANN] yaboot 1.3.6pre1 
Message-ID: <20011122003011.A7803@plato.local.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


yaboot 1.3.6pre1 is available for testing at:

http://master.penguinppc.org/projects/yaboot/1.3.6pre/

This version should now again work properly on IBM CHRP hardware, but
I would like it tested on both IBM CHRP and pmac to ensure both still
work properly.

IBM CHRP testing is especially wanted since I do /not/ have access to
this hardware.

Note that you must use ybin to install yaboot on IBM CHRP, if you
don't you must run addnote on the yaboot binary yourself, addnote is
installed at /usr/lib/yaboot/addnote.  Using ybin is highly recommended.

ChangeLog:

pre1:
        - The "IBM needs to test prereleases" release.
	- New IGNORE^H^H^H^H^H^HREADME, thanks to Chris Tillman for
	  cleaning up the pile of cruft that this thing was.
	- (ybin) Automatically use fstype=raw on IBM CHRP, it no longer needs
	  to be explicitly set in /etc/yaboot.conf.
	- Deprecate ybin's yaboot.conf auto-generation, use yabootconfig
	  instead.
	- Fix device path parsing to support devices containing a comma,
	  but not including a filename.
	- Fix IBM CHRP support.
	- Add support for zImage.initrd (Peter Bergner).


--
Ethan Benson
http://www.alaska.net/~erbenson/

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
