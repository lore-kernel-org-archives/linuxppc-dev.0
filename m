Message-ID: <2D9AB865A49FD511914700105A0EF679016C49C2@morse.smart.lfk.eads.net>
From: "Hager, Johannes, HRD/AB" <johannes.hager@eads.com>
To: "'Adrian Cox'" <adrian@humboldt.co.uk>,
	"PPC Linux Mailing List (E-Mail)" <linuxppc-embedded@lists.linuxppc.org>
Subject: RE: No L2 Cache on PReP Machine
Date: Thu, 19 Aug 2004 11:04:45 +0200
MIME-Version: 1.0
Content-Type: text/plain
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi,

>Generally Linux expects the boot firmware to set up the L2 and L3 caches
>on PowerPC machines. Are you quite sure (from benchmark timings) that
>the L2 cache is not working? The MVME3604 has an L2 cache outside the
>processor, and it should work transparently.
First the /proc/cpuinfo file contains the following informations:
processor	: 0
cpu		      : 604r
clock		: 400MHz
revision	      : 49.2 (pvr 0009 3102)
bogomips	: 399.76
machine	: PReP MVME 3600 with MVME761
l2 cache	: none
simms		:

I did the following test on this machine afte which I decided that the L2
cache is not used.
I have a test program on VxWorks which takes about 110 ms for execution on
the MVME3604 with enable L2 cache
I ported this application to a RTAI module and did the test on linux and it
took about 420ms
So i disabled the L2 cache in VxWorks and did the test again and then it
took with VxWorks about 417ms.
After this and because of the content from /proc/cpuinfo I decided that the
L2 cache is not used.

BTW I am using kernel 2.4.25

Best regards,
Johannes

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
