Return-Path: <shakthimaan@gmail.com>
Received: from zproxy.gmail.com (zproxy.gmail.com [64.233.162.206])
	by ozlabs.org (Postfix) with ESMTP id C7DA3685A3
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 26 Oct 2005 04:31:25 +1000 (EST)
Received: by zproxy.gmail.com with SMTP id i11so1039594nzh
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 25 Oct 2005 11:31:24 -0700 (PDT)
Message-ID: <d16b1c80510251125y7864354ao96f8262e17150aa6@mail.gmail.com>
Date: Tue, 25 Oct 2005 23:55:04 +0530
From: Shakthi Kannan <shakthimaan@gmail.com>
To: linuxppc-embedded@ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Subject: Development for Motorola MPC850DSL
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Greetings!

I have few queries on embedded GNU/Linux development for Motorola MPC850DSL=
.

1. Where can I find Linux kernel patches (2.6) specifically for the
Motorola series?

2. Are there existing drivers available for these peripherals?:

   SRAM - ST TC55V4000
   SDRAM - Micron 48LC4M16A2
   RS232 - MAX3243
   RS485 - MAX3089
   EEPROM - Atmel AT25010AN-10SI-2.7 - SPI port
   Ethernet PHY - Intel LXT905LC

3. Can this toolchain be used for 2.6 kernel compilation or do we need
to build one (maybe using Dan Kegel's scripts)?

http://www.connotech.com/gcc_mpc8xx/powerpc_eabi_mpc850.htm

Any feedback is appreciated.

Thanking you,

SK

--
Shakthi Kannan, MS
Software Engineer, Specsoft (Hexaware Technologies)
[E]: shakthimaan@gmail.com           [M]: (91) 98407-87007
[W]: http://www.shakthimaan.com   [L]: Chennai, India
