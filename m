Message-ID: <F14441D40E5AD3118886005004607AD10BDE13@MAIL1>
From: "Halfmann, Klaus" <khalfmann@libra.de>
To: linuxppc-dev@lists.linuxppc.org, linux-fsdevel@vger.kernel.org
Subject: Releasing Version 1.0.2 of hfsplusutils
Date: Wed, 25 Oct 2000 17:32:40 +0200
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


on 	ftp://penguinppc.org/users/hasi/hfsplusutils-1.0.2-3.ppc.rpm

resp.	ftp://penguinppc.org/users/hasi/hfsplusutils-1.0.2-3.src.rpm

You can download rpms of version 1.0.2 of my hfsplusutils.

The new version was neccessary because on large volumes
(> 2Gb) I must use lseek64.

Changes:
	Correctly checks for the existance
	of the backup volume record.

	has a btree node cache (does not speed up very much)
	has a blockiterator for files that speeds up hpcopy
		(especially with fragmented files)

	hpfsck is in the src-rpm but not int the binaries,
	as of now it does not check much.

	General code cleanup in preparing for write access.

Helpers welcome

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
