From: bitkeeper@bitkeeper.com
To: linuxppc-dev@lists.linuxppc.org, lm@bitmover.com,
	bitkeeper@bitmover.com
Subject: BK BUG: Bad fudges should be caught in commit trigger
Message-Id: <20020120111314.940A81008D@hostme.bitkeeper.com>
Date: Sun, 20 Jan 2002 03:13:14 -0800 (PST)
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


View Bug:

http://bitkeeper.bitkeeper.com/cgi-bin/bugview?open/2002-01-20-001

Bug ID:
	2002-01-20-001

Submitter:
	lm@bitmover.com

Type:
	RFE

Summary:
	Bad fudges should be caught in commit trigger

Severity:
	3

Priority:
	4

Status:
	open

Program:
	delta

Release:
	BitKeeper version is 20020117053606 for x86-glibc22-linux

OS:
	Linux work.bitmover.com 2.4.9-13 #1 Tue Oct 30 20:05:14 EST 2001 i686 unknown


Interest:
	linuxppc-dev@lists.linuxppc.org
lm@bitmover.com,bitkeeper@bitmover.com

Description:

Suppose we have a system where time goes backwards or really far
forwards.  When we go to do the commit, we could have a time
sanity trigger which flags this as a possible error and asks them
to go fix their clocks before doing the checkin.


Suggestion:
	This really wants to be a pre-delta trigger and it needs to work from
citool as well as the command line.  So we have to pass state to it
to tell it that it is a GUI app and we need a way to get a yes/no
from the pop up.
As for the time itself, if the time goes backwards more than a day,
flag that, and if it goes forward for more than a month, flag that.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
