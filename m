Return-Path: <owner-linuxppc-embedded@lists.linuxppc.org>
Message-ID: <DB0585C9F6F9D411BE8F00D0B7896A4CC06038@SNCMAIL>
From: James Don <JDon@spacebridge.com>
To: "'Der Herr Hofrat'" <der.herr@mail.hofr.at>
Cc: "'linuxppc-embedded@lists.linuxppc.org'" <linuxppc-embedded@lists.linuxppc.org>
Subject: RE: RAMDISK IMAGES(2): ash has no job control ??? ... can't acces
	s tt y; job control turned off
Date: Sun, 12 Jan 2003 14:34:26 -0500
MIME-Version: 1.0
Content-Type: text/plain
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Thanks,
But that's not it ... I just checked that BB_FEATURE_ASH_JOB_CONTROL is
compiled in ... I think problem may be:

When it says " can't access tty" ... maybe it should say ttyS00 because "
ttyS00 at 0x0280 is a SMC" on my mpc860 ... I will have to keep digging ;-)

Jim

-----Original Message-----
From: Der Herr Hofrat [mailto:der.herr@mail.hofr.at]
Sent: Sunday, January 12, 2003 2:25 PM
To: James Don
Cc: 'linuxppc-embedded@lists.linuxppc.org'
Subject: Re: RAMDISK IMAGES(2): ash has no job control ??? ... can't access
tt y; job control turned off

>
> Hi,
>
> I am looking at a ramdisk image ... I am curious if anyone could give me a
> tip as to why when my bash starts I have no "job contol" (ctrl-z etc) ...
se
> below ...
>
> BusyBox v0.60.5 (2003.01.09-00:51+0000) Built-in shell (ash)

busybox builtin shell has no job control by default - for ash you have to
enable it at compile time.

hofrat

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
