Message-ID: <D73A25AA6E54D511AD74009027B1110F5BB190@ORION>
From: Steven Blakeslee <BlakesleeS@embeddedplanet.com>
To: "'Meriin Michael-BMM063'" <BMM063@motorola.com>,
	"'linuxppc-embedded@lists.linuxppc.org'" <linuxppc-embedded@lists.linuxppc.org>
Subject: RE: MPC852 Cache initializing problem
Date: Mon, 19 Apr 2004 12:42:56 -0400
MIME-Version: 1.0
Content-Type: text/plain;
	charset="windows-1255"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


It may be your debugger that is causing the problem.  The next thing called
is turn_on_mmu and I believe that causes an exception.

-----Original Message-----
From: Meriin Michael-BMM063 [mailto:BMM063@motorola.com]
Sent: Monday, April 19, 2004 11:57 AM
To: 'linuxppc-embedded@lists.linuxppc.org'
Subject: MPC852 Cache initializing problem



Hello,

I'm trying to put Linux on MPC852T platform (Embedded Planet).
I'm using UBOOT as a Boot Loader.
I'm trying to put kernel 2.4.20
On the very beginning of the Linux Initializing
in "initial_mmu" after enabling Cache the system crashes.
Any ideas?

Thanks,

Best Regards,
     Michael Meriin


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
