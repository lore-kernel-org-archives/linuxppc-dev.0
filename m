Message-ID: <3905568B.22D4E45F@enib.fr>
Date: Tue, 25 Apr 2000 10:25:47 +0200
From: Valéry Raulet <Valery.Raulet@enib.fr>
MIME-Version: 1.0
To: "linuxppc-embedded@lists.linuxppc.org"
 <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: Boot failed with new 2.3.99 kernel !
Content-Type: text/plain; charset=iso-8859-1
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi all,

the following part seems sticky for my board.

>>NIP; c0184da8 <prep_route_pci_interrupts+d0/3d0>   <=====
Trace; 00000000 Before first symbol
Trace; c01850dc <prep_pcibios_fixup+34/188>
Trace; c017fa88 <pcibios_init+44/60>
Trace; c0195868 <pci_init+14/58>
Trace; c017e7a8 <do_basic_setup+20/190>
Trace; c00039fc <init+14/1a8>
Trace; c0008e30 <kernel_thread+2c/38>
>>NIP; c0184da8 <prep_route_pci_interrupts+d0/3d0>   <=====

After having a close look to 'prep_pci.c', it seems that this test
'*ProcInfo &MOT_PROC2_BIT' in 'prep_route_pci_interrupts(void)' cause
troubles.

What happens ? Any ideas ?

--
Valéry RAULET

Ecole Nationale d'Ingénieurs de Brest
Parvis Blaise Pascal
Technopôle Brest-Iroise
29280 PLOUZANE
Site Web : http://www.enib.fr/~raulet


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
