Message-ID: <DB0585C9F6F9D411BE8F00D0B7896A4CC05FC8@SNCMAIL>
From: James Don <JDon@spacebridge.com>
To: "'linuxppc-embedded@lists.linuxppc.org'" <linuxppc-embedded@lists.linuxppc.org>
Subject: Whats the "standard" embedded C lib?
Date: Tue, 7 Jan 2003 16:12:09 -0500 
MIME-Version: 1.0
Content-Type: text/plain
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi there,

I am just looking at compiling "busybox". And am now at a point where I need
to consider more than just the kernel and my bootloader.

I have build my gcc 2.95.3 using newlib (from redhat I believe) ...

I am having some troubles building busy box ... as I need to sort our which
'headers' to include etc ...

I think I am on the right track to completing this but I read something in
the busy box makefile that kind of stirred my confidence ... it said uClib
is best with busy box ... is this the same as newlib?

What embedded C lib do you folks recommend? (for PPC 860 if that matters)

Regards,
Jim

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
