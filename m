Message-ID: <20000129082907.13106.qmail@web1006.mail.yahoo.com>
Date: Sat, 29 Jan 2000 00:29:07 -0800 (PST)
From: Dan Bethe <dan_bethe@yahoo.com>
Subject: Re: HFS+ format
To: linuxppc-dev@lists.linuxppc.org
Cc: LinuxPPC Developer <linuxppc-dev@lists.linuxppc.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>



> I think part of the problem is the license.  I believe everything
> incorporated in the Linux kernel, including modules, has to be under the
> GPL license, as it covers linking and (debatably) dynamic linking.  So a
> direct port wouldn't be possible, due to the incompatible licenses.  The
> code would have to be rewritten from scratch.

	That would be the case if software ported from BSD or from an Apple product,
was to be made part of the standard kernel distribution.  It is not necessary
for all kernel modules to be GPL.  For example, see the OSS commercial drivers.
 And VMware's GPL kernel modules that support their proprietary commercial
application.  :)
	So I'd say that it's cool to port it if that's very easy, then let people
include it on their own or as a LinuxPPC RPM, and then see about including it
straight into the kernel.
	IMHO!

=====
"Don't expect your own messiah; this neverworld which you desire is
only in your mind." -- http://www.dreamtheater.net/songb4.htm#IV5

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
