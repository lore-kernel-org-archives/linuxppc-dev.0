Message-Id: <5.1.0.14.2.20030112120542.02d6e878@pop.prodigy.net>
Date: Sun, 12 Jan 2003 12:08:48 -0800
To: James Don <JDon@spacebridge.com>
From: Eugene Surovegin <ebs@innocent.com>
Subject: Re: RAMDISK IMAGES(2): ash has no job control ??? ... can't
  access tt y; job control turned off
Cc: linuxppc-embedded@lists.linuxppc.org
In-Reply-To: <DB0585C9F6F9D411BE8F00D0B7896A4CC06037@SNCMAIL>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


James,

At 11:19 AM 1/12/2003, you wrote:
>I am looking at a ramdisk image ... I am curious if anyone could give me a
>tip as to why when my bash starts I have no "job contol" (ctrl-z etc) ... se
>below ...
>
>BusyBox v0.60.5 (2003.01.09-00:51+0000) Built-in shell (ash)
>Enter 'help' for a list of built-in commands.
>sh: can't access tty; job control turned off


Look at inittab for busybox.

There should be the line which starts shell on system console:

::askfirst:-/bin/sh

Change it to somethinbg like:

ttyS0::askfirst:-/bin/sh

where the first name is the name of your console device, in this case I
have console on serial port


  Eugene Surovegin <mailto:ebs@innocent.com>


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
