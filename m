From: "Stefano Coluccini" <s.coluccini@caen.it>
To: <linuxppc-embedded@lists.linuxppc.org>
Subject: MVME5100
Date: Tue, 6 Feb 2001 16:44:42 +0100
Message-ID: <NDBBIFIMCKPOADMAJOKMOEHCCOAA.s.coluccini@caen.it>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi guys,
  I've a MVME5100 and I'm trying to port linux on it but I've many problems
because I'm not a PowerPC/PReP/CHRP expert. I've correctly patched the boot
loader (remapping the UART in ns16550.h) so I can see its messages on my
terminal emulator, but the boot process hangs after the "Now booting the
kernel" printout (a little too early :-(). I've read some archived articles
and it seems to me that I've to do many other remapping for the MMU and
interrupts but my efforts didn't get results. Is there anyone can give me
some useful hints ?

I've started the port from a Debian kernel source ver. 2.2.18.
I haven't a IPMC761 transition module (it seems important for interrupts ...
or doesn't ?)

Thanks in advance.
Stefano.

+--------------------------------------------------------+
! Stefano Coluccini         ! CAEN Engineering srl       !
! Via Vetraia, 11           ! 55049 Viareggio (LU)-ITALY !
! Tel. +39 0584 388 398     ! Fax +39 0584 388 959       !
! s.coluccini@caen.it       ! www.caen.it/computing      !
+--------------------------------------------------------+

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
