From: "Joakim Tjernlund" <joakim.tjernlund@lumentis.se>
To: "Linuxppc-Embedded@Lists. Linuxppc. Org" <linuxppc-embedded@lists.linuxppc.org>
Subject: Serial port text corruption
Date: Tue, 18 May 2004 12:03:04 +0200
Message-ID: <JPEALJAFNGDDLOPNDIEECEJBCIAA.joakim.tjernlund@lumentis.se>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Details:
Sometimes when connecting the RS323 port between a laptop on our custom board
to login into a bash shell it looks like this:

Press return to get a login prompt, type username(root), hit return. Now
I expect to see the "Password: " prompt, but instead I see
random crap chars. Wait until the login timeouts, about 60 seconds, the timeout message
is also crap chars, but the following login prompt displays OK and now
I can login without any crap chars.

This is very confusing and I would fix it but I don't know where to start.
Any guesses as to where the problem is? Kernel serial layer, the 8xx uart.c driver,
the user space login program or somewhere else?

SMC1 is the serial HW used on a 860/862 CPU.
Kernel: linuxppc_2_4_devel from around 2.4.21-rc6 with all 8xx_io/uart.c patched to
current 2.4 version.
Userspace progs are from MontaVista hardhat 2.0. Login uses PAM.

 Jocke

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
