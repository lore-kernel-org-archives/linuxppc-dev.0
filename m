Date: Mon, 14 Feb 2000 14:38:09 -0500
From: Josh Huber <huberj@wpi.edu>
To: Linux/PowerPC Devel List <linuxppc-dev@lists.linuxppc.org>
Subject: 2.3.x w/pcmcia?
Message-ID: <20000214143809.B8313@wpi.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


I'd like to try and get PCMCIA working with later development kernels.  In
particular, the file i82365.c from pcmcia-cs 3.1.10 has code like this:

/* These definitions must match the pcic table! */
typedef enum pcic_id {
#ifdef CONFIG_ISA
    [isa cards]
#endif
#ifdef CONFIG_PCI
    [pci cards]
#endif
}

The i82365.c file in the 2.3.45 kernel doesn't have any CONFIG_PCI sections,
leaving empty enums, which fail to compile. like so:
typedef enum pcic_id {
#ifdef CONFIG_ISA
    [isa cards]
#endif
}

The pcmcia-cs package fails to compile becuase it requires that pcmcia be
enabled in the kernel for versions past 2.3.37.

Why is the pcmcia in the kernel so
a) out of date
b) screwed up, in that it doesn't have support for PCI???

Josh

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
