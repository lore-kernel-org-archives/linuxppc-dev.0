Message-ID: <20040319020718.10196.qmail@web21113.mail.yahoo.com>
Date: Thu, 18 Mar 2004 18:07:18 -0800 (PST)
From: Lou Rickard <lou_rickard@yahoo.com>
Subject: coffboot?
To: linuxppc-embedded@lists.linuxppc.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


I've been given the task of developing on an embedded
ppc device called an ipengine.  One of the things I'm
supposed to do is use to update the kernel, from 2.2
which comes with the build environment, to 2.4.

I've been pretty unsuccsessful so far.  I can build a
zImage.gz file, include it in the ramdisk, load, start
it, but when it comes to the point where it
uncompresses the kernel, it hiccups back to the start
point.

For the build environment that comes with it, the
kernel used is in the coffboot directory, which I
don't understand.  As I understand it, coffboot would
be used for making boot floppies, right?  So is there
a difference between a zImage built "normally" and one
that would be built for coffboot?  What would I need
to do to get my 2.4 kernel converted over to the
format used by the 2.2 coffboot kernel?

Thank you,

~lr


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
