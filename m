From: Cort Dougan <cort@fsmlabs.com>
Date: Fri, 21 Jun 2002 10:37:10 -0600
To: Naushit Sakarvadia <naushit@softhome.net>
Cc: LinuxPPC <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: Fw: SMP Support
Message-ID: <20020621103710.C13628@host110.fsmlabs.com>
References: <008601c218b3$ec8b25f0$7402a8c0@QUINTUMCHI.COM>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <008601c218b3$ec8b25f0$7402a8c0@QUINTUMCHI.COM>; from naushit@softhome.net on Thu, Jun 20, 2002 at 06:40:53PM -0500
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


There are some tricks for the 750 on SMP that no-one has actually tried
yet.  I did some early work with it that ended up with horrible
performance.  The 750's don't broadcast TLB invalidates and that really
messes SMP up for us.

I'm not sure of the 755 follows in this tradition but I'd suggest checking
carefully for that.  SMP works well on anything other than 750's, though.

} I was wondering if there is SMP support  for TWO Processors
} in Powerpc based Embedded Sytem.
}
} I have 2  MPC755 Processors  sharing one 60x Bus.
} Both of  them have 1MB of L2 Cache, and Share DRAM connected to 60x bus.
}
}
} Have anybody already used powerpc SMP??
} Have anybody used M-system Disk-on-Chip 2000 with PowerPC linux?
} How about Powerspan PCI bridge support??
}
}
} Thanks for any pointers
}
} Naushit.
}
}

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
