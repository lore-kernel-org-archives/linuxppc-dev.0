Message-ID: <DB0585C9F6F9D411BE8F00D0B7896A4CC05F2F@SNCMAIL>
From: James Don <JDon@spacebridge.com>
To: "'Jean-Denis Boyer'" <jdboyer@mediatrix.com>,
	James Don <JDon@spacebridge.com>
Cc: Embedded Linux PPC List <linuxppc-embedded@lists.linuxppc.org>
Subject: RE: Unable to mount root fs on 01:00 ... 
Date: Mon, 16 Dec 2002 15:14:37 -0500
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Indeed you were correct ...

No everything seems to work ... bash shell and all ...

-----Original Message-----
From: Jean-Denis Boyer [mailto:jdboyer@mediatrix.com]
Sent: Monday, December 16, 2002 3:00 PM
To: James Don
Cc: Embedded Linux PPC List
Subject: RE: Unable to mount root fs on 01:00 ...


James,

> Kernel panic: VFS: Unable to mount root fs on 01:00

Did you include EXT2 file system in your kernel image?
If not, you would obtain this error.

Regards,
--------------------------------------------
 Jean-Denis Boyer, B.Eng., Technical Leader
 Mediatrix Telecom Inc.
 4229 Garlock Street
 Sherbrooke (Québec)
 J1L 2C8  CANADA
 (819)829-8749 x241
--------------------------------------------

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
