Date: Tue, 23 Nov 1999 10:46:26 -0700
From: Cort Dougan <cort@fsmlabs.com>
To: David Edelsohn <dje@watson.ibm.com>
Cc: Christian Zankel <chris@mvista.com>, linuxppc-dev@lists.linuxppc.org,
        linuxppc-embedded@lists.linuxppc.org
Subject: Re: bootloader & head.S weirdness & restructuring
Message-ID: <19991123104626.D16540@hq.fsmlabs.com>
References: <cort@fsmlabs.com> <9911231617.AA25176@marc.watson.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <9911231617.AA25176@marc.watson.ibm.com>; from David Edelsohn on Tue, Nov 23, 1999 at 11:17:57AM -0500
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


That's what we do, in fact.  The problem is not stomping on the OF vectors
stored at physical 0 on chrp (on pmac they're at the high vector table not
the low one) so we load above that, do our prom calls then relocate to phys 0.

} 	Why not have the kernel define, or at least reserve space for, the
} interrupt vectors?  If one specifies the correct padding and/or alignment,
} the interrupt vector code will appear at the correct offsets when the
} kernel is loaded at 0.  The kernel can start at 0, not its entry point or
} normal code.
} 
} David

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
