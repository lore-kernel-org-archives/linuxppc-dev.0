Date: Mon, 4 Jan 1999 18:48:40 -0700 (MST)
From: Cort Dougan <cort@persephone.cs.nmt.edu>
To: Dan Malek <dmalek@jlc.net>
cc: Paul Mackerras <paulus@cs.anu.edu.au>,
        Geert Uytterhoeven <Geert.Uytterhoeven@cs.kuleuven.ac.be>,
        bh40@calva.net, tmrini@ntplx.net, linuxppc-dev@lists.linuxppc.org
Subject: Re: irq cleanup
In-Reply-To: <36901B63.5F905878@jlc.net>
Message-ID: <Pine.LNX.3.96.990104184703.27992A-100000@persephone.cs.nmt.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Right, the winbond has a couple 8259's emulated on it.  They're routed to
irq 3 on the 8xx.  

}I am a little confused by this.  I am travelling and don't have
}my books handy. and I remember the MBX uses the 8259
}interrupt controller to manage all PCI/ISA device interrupts.
}What I don't remember are the actual connections.  I believe
}the PCI interrupts are routed to the 8259, which is then
}routed to one of the 8xx external interrupts.

I think some devices can be routed through the qspan as well.  The docs I
have are not clear.

}The QSPAN interrupts are for things like PCI parity

Right, that's the plan.

}To support PCI or ISA devices that interrupt on the MBX
}you would need to modify irq.c to support a multilevel interrupt
}scheme.  The 8259 would interrupt on one of the 8xx interrupt
}controller levels, then you would have to process all 8259
}interrupts.


[[ This message was sent via the linuxppc-dev mailing list. Replies are ]]
[[ not forced back to the list, so be sure to  Cc linuxppc-dev  if your ]]
[[ reply is of general interest. To unsubscribe from linuxppc-dev, send ]]
[[ the message 'unsubscribe' to linuxppc-dev-request@lists.linuxppc.org ]]
