Content-Type: text/plain;
  charset="iso-8859-1"
From: "Manuel Tovar Dall'Orso" <mtovar@tcc.com.pe>
Reply-To: mtovar@tcc.com.pe
To: linuxppc-embedded@lists.linuxppc.org
Subject: MPC823 -  serial input problem in LCD
Date: Fri, 8 Feb 2002 13:01:37 -0500
MIME-Version: 1.0
Message-Id: <02020813013700.01872@id05.tcc.com>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


We have an embedded TQM823 system working with a TFT Prime View V16C6448, in
ppcboot-1.1.3 after settings the lcd.c file the system display the info in
the LCD and our input comes from the Keyboard of the PC attached to the STK
by a SMC1 (serial line).  When we configure the system for mounting rootp
artition by NFS in linux, the output works fine but our input for keyboard
fails.



Description
===========
Source --->    kernel 2.4.4-2002-01.19
adding ld.so.1 from ftp://ftp.denx.de/pub/LinuxPPC/usr/src/ld.so.1.tar.bz2
CrossCompiler -> CDK from denx, LinuxPPC-2.2.13 for TQM823L(27_Jan_2000)

Our STK8xx (TQM823L_module) have been setup for TFT Prime View V16C6448AC
compatibility, in ppcboot-1.1.3 the TFT output, and PC Keyboard input works
perfect in the communications made by SMC1




NFS-Compiling
=============
For compiling:    > make TQM823L_LCD_config

Addings:  > Plataform Suport   -> standalone shell = /bin/sash

              > MPC8xx CPM Options -> Type of LCD Display

                           arch/ppc/8xx_io/lcd823.c
                           arch/ppc/8xx_io/Config.in
                            (modify for our TFT like ppcboot)

we setup /dev/console->tty0

That works OK, the system initialize and we got the prompt in the TFT, but we
don't have access to the system by the keyboard of the PC connected to the
STK by the serial line SMC1.


Question
=======

We need to configure another thing in the kernel for working with that serial
imput ?



Regards Manuel

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
