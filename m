Subject: uart.c doesn't compile
From: Jaap-Jan Boor <jjboor@aimsys.nl>
To: linuxppc list <linuxppc-embedded@lists.linuxppc.org>
Content-Type: text/plain
Message-Id: <1092814249.23185.15.camel@linpc003.aimsys.nl>
Mime-Version: 1.0
Date: Wed, 18 Aug 2004 09:30:50 +0200
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi,

I pulled the latest linuxppc-2.5 using bk and try
to build for 8xx (FADS). It seems uart.c doesn't
build anymore for SMCs:

  CC      arch/ppc/8xx_io/uart.o
arch/ppc/8xx_io/uart.c: In function `change_speed':
arch/ppc/8xx_io/uart.c:992: warning: implicit declaration of function
`m8xx_cpm_setbrg'
arch/ppc/8xx_io/uart.c: In function `rs_8xx_init':
arch/ppc/8xx_io/uart.c:2689: error: `dp_addr' undeclared (first use in
this function)
arch/ppc/8xx_io/uart.c:2689: error: (Each undeclared identifier is
reported only once
arch/ppc/8xx_io/uart.c:2689: error: for each function it appears in.)
make[1]: *** [arch/ppc/8xx_io/uart.o] Error 1
make: *** [arch/ppc/8xx_io] Error 2

should dp_addr not be changed in dp_offset?

Jaap-Jan

--
J.G.J. Boor                       Anton Philipsweg 1
Software Engineer                 1223 KZ Hilversum
AimSys bv                         tel. +31 35 689 1941
Postbus 2194, 1200 CD Hilversum   mailto:jjboor@aimsys.nl


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
