Message-ID: <4050D15F.1070308@mvista.com>
Date: Thu, 11 Mar 2004 14:51:43 -0600
From: Mark Hatle <mhatle@mvista.com>
MIME-Version: 1.0
To: Stuart Yoder <stuart.yoder@conformative.com>
Cc: LinuxPPC <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: version of gcc
References: <03e401c407a5$2bd19410$3000a8c0@foundation>
In-Reply-To: <03e401c407a5$2bd19410$3000a8c0@foundation>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


My advice is to always use the gcc that your vendor recommends.  If you
do not have a vendor, find one and see what they recommend.. <grin>  The
easiest vendor to see is the ELDK.

Note, thos recommendations in the Documentation file are generally
specific to x86.  PPC the newer gcc compilers are sometimes required for
different architectures.

--Mark

Stuart Yoder wrote:
> The 2.4 kernel Documentation/Changes file has the following note:
>
> The recommended compiler for the kernel is gcc 2.95.x (x >= 3), and it
> should be used when you need absolute stability. You may use gcc 3.0.x
> instead if you wish, although it may cause problems. Later versions of gcc
> have not received much testing for Linux kernel compilation, and there are
> almost certainly bugs (mainly, but not exclusively, in the kernel) that
> will need to be fixed in order to use these compilers.
>
> Is this still true?  The comment appears to be > 2 years old.  I am running
> gcc 3.2.2 and wondering if I'm asking for trouble.   Do I really need to
> revert back to an old compiler?
>
> Thanks,
> Stuart
>
>
>
>


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
