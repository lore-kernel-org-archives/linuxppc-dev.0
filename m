Message-ID: <3AD4722B.3B22120@matrox.com>
Date: Wed, 11 Apr 2001 11:03:07 -0400
From: =?iso-8859-1?Q?S=E9bastien=20C=F4t=E9?= <scote1@matrox.com>
MIME-Version: 1.0
To: LinuxPPC-embedded list <linuxppc-embedded@lists.linuxppc.org>
Subject: frequency in sandpoint_calibrate_decr
Content-Type: text/plain; charset=iso-8859-1
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi,

In MontaVista's kernel 2.4.0-test2, the frequency in
sandpoint_calibrate_decr() is set to 66 Mhz.  What frequency is this?
The processor, the bus ???

Increasing this speed seems to get rid of my stability problems (at
last!), so I'd like to know the real value I should put there.

Thanks,

Sébas..

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
