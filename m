From: Darin.Johnson@nokia.com
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Subject: RE: [RFC] consistent_sync and non L1 cache line aligned buffers
Date: Tue, 15 Jul 2003 13:47:24 -0700
Message-ID: <F0B628F30F48064289D8CCC1EE21B7A80C48A7@mvebe001.americas.nokia.com>
To: <linuxppc-embedded@lists.linuxppc.org>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


> Well, I would be, of the USB code.  SCSI might have had it fixed, and
> others that we haven't found yet may or may not.  But the important
> point is that doing this is a driver bug and it's OK to beat driver
> authors over the head with patches to fix the behavior. :)

I don't necessarily agree.  It's an argument over what is
broken - the invalidate routine that makes assumptions, or the
device writer that assumes the interface functions work as
claimed, or the documentation that doesn't exist?

It's fine to beat the driver authors over the head with the
fact that the functions don't necessarily do what their
names imply.  And it's fine to discourage authors from doing
DMA on the stack (that's a separate issue from unaligned
buffers).

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
