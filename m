Subject: RE: 2.6 kernel ppc tree
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Date: Wed, 18 Feb 2004 10:30:41 +1300
Message-ID: <A3240F62EF3C2749B1A25D3BC9548F410309FE@ExchWENZ02.wenz.global.vpn>
From: "Rod Boyce" <rod_boyce@stratexnet.com>
To: "Lokesh Kumar" <kumar.lokesh@wrx-us.com>,
	<linuxppc-embedded@lists.linuxppc.org>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


I downloaded the the 2.6.1 Linux kernel and compiled it for the RPX-Lite board.  I discovered that the UART driver in arch/ppc/8xx_io/ has not been ported to the 2.6 kernel otherwise I had no problems.  I have not had time to get back to the 2.6 porting effort and update the uart.c file.  If ther eis another one out there I could try it out but that is where I left my effort.  Otherwise I would guess you may not have too many more problems but I have not been able to spend much time on this.

Regards,
Rod Boyce

-----Original Message-----
From: owner-linuxppc-embedded@lists.linuxppc.org
[mailto:owner-linuxppc-embedded@lists.linuxppc.org]On Behalf Of Lokesh
Kumar
Sent: Wednesday, February 18, 2004 10:22 AM
To: linuxppc-embedded@lists.linuxppc.org
Subject: 2.6 kernel ppc tree



Is there a tree for ppc for 2.6 kernel, which I can download and compile for
mpc8xx based boards? Any help is welcome.

Lokesh Kumar
Wireless Matrix USA Inc.
703-262-4032


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
