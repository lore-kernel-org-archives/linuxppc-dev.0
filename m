Message-ID: <3B34CA3C.85F61D60@mvista.com>
Date: Sat, 23 Jun 2001 12:56:28 -0400
From: Dan Malek <dan@mvista.com>
MIME-Version: 1.0
To: Matthew Locke <mlocke@mvista.com>
Cc: yooth@ipone.co.kr,
	linuxppc-embedded <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: Starting usb in RPXlite(mpx850) board
References: <NFBBLHGHILCOPCKBODHAEEPHCAAA.yooth@ipone.co.kr> <3B341B5B.2090301@mvista.com>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Matthew Locke wrote:

> uh, I believe so.  If I remember correctly, USB is only supported on the
> 823 rpxlite DW.

...and, if I recall correctly, the CPM microcode patch to enable this
was written for the Rev. B 823(e).  I know it won't work on a Rev. A 823
part, and we never pursued making it work on an 850 due to lack of a
board
with USB.  It would also require the Rev. B 850 if there was any hope
of it working there.


	-- Dan

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
