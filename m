Message-ID: <3857E630.5B63BD3E@netx4.com>
Date: Wed, 15 Dec 1999 14:04:16 -0500
From: Dan Malek <dan@netx4.com>
MIME-Version: 1.0
To: bsimon@ctam.com.au
CC: linuxppc-embedded <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: linuxppc embedded boot problems.
References: <3856C0D7.4E1404C9@ctam.com.au> <385703C2.AA4298E7@netx4.com> <38570544.476D42C9@ctam.com.au> <385714D8.8AD74656@netx4.com> <3857103E.6608A366@ctam.com.au>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Brendan Simon wrote:


> I now get the attached output.  Notice the "VFS: Mounted root (NFS
> filesystem) readonly." message.



At some point, long ago, the generic kernel root mounting had
a subtle change for some reason.  The result is that all file
systems are now mounted read-only by default.  All you need
to do is add "rw" to the command line.  It should look like
this: root=/dev/nfs rw......Now, the more interesting part is
I thought I did that as part of the default command line in
arch/ppc/mbxboot/misc.c......where did it go?



	-- Dan

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
