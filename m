From: "Stefano Coluccini" <s.coluccini@caen.it>
To: "Linuxppc-Embedded" <linuxppc-embedded@lists.linuxppc.org>
Subject: Interrupt notification in PPCBug
Date: Thu, 11 Apr 2002 09:54:07 +0200
Message-ID: <NDBBIFIMCKPOADMAJOKMKEMKECAA.s.coluccini@caen.it>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi,
  I'm sorry if this is an OT question, but many of you are also PPCBug
expert and I hope someone of you can help me for this little trouble.
I have a MCPN765 non-system board and whenever some pci device raise an
interrupt (also behind the transparent bridge of my system board) PPCBug
notify this. This behaviour prevent me to use my system board as the
bootp/tftp/nfs server to boot linux for the non-system board because
notification of the interrupts of the NIC on the system board break the NBO
command.
There is a way to disable this behaviour on PPCBug ?

Thanks in advance.
Stefano.

+--------------------------------------------------------+
! Stefano Coluccini         ! CAEN SpA - Computing Div.  !
! Via Vetraia, 11           ! 55049 Viareggio (LU)-ITALY !
! Tel. +39 0584 388 398     ! Fax +39 0584 388 959       !
! s.coluccini@caen.it       ! www.caen.it/computing      !
+--------------------------------------------------------+


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
