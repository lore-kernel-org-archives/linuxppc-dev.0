Message-Id: <9911231617.AA25176@marc.watson.ibm.com>
To: Cort Dougan <cort@fsmlabs.com>
Cc: Christian Zankel <chris@mvista.com>, linuxppc-dev@lists.linuxppc.org,
        linuxppc-embedded@lists.linuxppc.org
Subject: Re: bootloader & head.S weirdness & restructuring 
In-Reply-To: Message from Cort Dougan <cort@fsmlabs.com>
   of "Mon, 22 Nov 1999 16:55:35 MST." <19991122165535.A13360@hq.fsmlabs.com>
Date: Tue, 23 Nov 1999 11:17:57 -0500
From: David Edelsohn <dje@watson.ibm.com>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


	Why not have the kernel define, or at least reserve space for, the
interrupt vectors?  If one specifies the correct padding and/or alignment,
the interrupt vector code will appear at the correct offsets when the
kernel is loaded at 0.  The kernel can start at 0, not its entry point or
normal code.

David

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
