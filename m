Message-Id: <5.0.2.1.0.20010627091411.00a56b90@pop.gmx.de>
Date: Wed, 27 Jun 2001 09:17:12 +0800
To: Matthew Locke <mlocke@mvista.com>
From: Michael Habermann <MHabermann@gmx.de>
Subject: Re: Segmentation fault while dynamic linking
Cc: linuxppc-embedded@lists.linuxppc.org
In-Reply-To: <3B38C289.7050008@mvista.com>
References: <5.0.2.1.0.20010626172652.00a69210@pop.gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


At 10:12 AM 6/26/2001 -0700, Matthew Locke wrote:
>>My configuration: Kernel 2.4.4, glibc 2.2.2, bash 2.05, FADS, MPC855T
>
>who's toolchain are you using?  glibc 2.2.x has a cacheline size bug for
>the smaller cacheline ppc processors.  Our toolchain has a fix for it.
>grab our HHL 2.0 Journeyman edition and give it a try. http://www.mvista.com

binutils 2.11.2
gcc 2.95.3
glibc 2.2.2

Everything unpatched and downloaded from ftp.gnu.org.

I've read in the mailing list, that the glibc needs to be patched. But I've
found that the most changes are already made at glibc2.2.2, so I assumed it
should work.

The kernel is 2.4.4 from ftp.denx.de, patched by a patch posted from Dave
Ellis.

Ok, I try the mvista glibc.


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
