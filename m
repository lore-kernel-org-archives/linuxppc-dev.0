Message-ID: <3A59E708.5E9375CD@GreenCurrent.com>
Date: Mon, 08 Jan 2001 18:12:56 +0200
From: Juha Okkonen <Juha.Okkonen@GreenCurrent.com>
MIME-Version: 1.0
To: "\"LinuxEmbeddedMailList" <linuxppc-embedded@lists.linuxppc.org>
Subject: MV kernel on 405GP
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


	I have a custom board that uses IBM 405GP -prosessor. I have already
	modified ppcboot-0.5.3 for booting. And am trying to get Monta Vista's
	linux-2.4.0-test2 kernel to run on it also. But there is some problem
	with exceptions. When start_kernel(void)-function calls sti() to enable
	external interrupts, the prosessor hangs totally. I don't get any
register
	dumps or anything else either. I have been able to verify with kgdb
that
	everything works until update of MSR-register.

	If somebody has a version of the kernel modified for 405GP and ppcboot
	both working, I would like to have the sources or at least ideas about
	my problemn.

							'Okko


--
Juha Okkonen/CTO			         Juha.Okkonen@GreenCurrent.com
Green Current Oy				 Phone +358  9 2517 5525
Tekniikantie 21 E 226					      +358 41  517 6542
02150 Espoo

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
