Message-ID: <8D7C5F56B409554D9D46AC22195807F3061D69@exchwenz01.dmcwave.co.nz>
From: Rod Boyce <rod_boyce@stratexnet.com>
To: "'Lokesh Kumar'" <kumar.lokesh@wrx-us.com>,
	"'linuxppc-embedded@lists.linuxppc.org'" <linuxppc-embedded@lists.linuxppc.org>
Subject: RE: mpc8xx memory mapped 16550 extrenal uart driver
Date: Mon, 6 Oct 2003 07:35:25 +1300 
MIME-Version: 1.0
Content-Type: text/plain
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


The standard serial driver will work in this mode without modification.
This is how we are using it on our MPC860 board.


Rod

> -----Original Message-----
> From: Lokesh Kumar [mailto:kumar.lokesh@wrx-us.com]
> Sent: Saturday, 4 October 2003 1:02 a.m.
> To: 'linuxppc-embedded@lists.linuxppc.org'
> Subject: mpc8xx memory mapped 16550 extrenal uart driver
>
>
> Hi gurus,
>
> Does anybody know of a driver for an external 16550 memory mapped uart
> driver for an mpc855 based board? Any help is appreciated?
>
>
> Lokesh Kumar
> Wireless Matrix USA Inc.
> 703-262-4032
>
>

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
