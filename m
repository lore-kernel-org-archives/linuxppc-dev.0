Message-ID: <DB0585C9F6F9D411BE8F00D0B7896A4CC060FF@SNCMAIL>
From: James Don <JDon@spacebridge.com>
To: linuxppc-embedded@lists.linuxppc.org
Subject: Question: insmod QM_MODULES
Date: Thu, 23 Jan 2003 22:46:17 -0500
MIME-Version: 1.0
Content-Type: text/plain
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi,

I am having troubles loading a simeple module with my 2.4.20pre8 kernel from
m-vista on my ppc custom board (similar to fads).

I keep getting the message:
	insmod: QM_MODULES : Function not implemented

I have done a whole bunch of reading and I think I have all my basis
covered:

1.) kernel has module support compiled in ...
2.) I am using modutils 2.4.20 ...
3.) after compiling in module support I rebuilt ulibc to be safe ...

>From what I have read any kernel newer than 2.1 should have support for
"query on modules" ...

Any enlightenment would be much appreciated,
Jim

Ps weird fact despite the fact I have compile in modules in my
include/config/modules.h file there is a undef CONFIG_MODULES ... which
seems weird to me ... could this be a hint ... should I do a make clean then
make dep ... or is make dep then make zImage ok normally?

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
