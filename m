From: Cort Dougan <cort@fsmlabs.com>
Date: Thu, 20 Feb 2003 12:40:29 -0700
To: Paul Mackerras <paulus@samba.org>
Cc: brian.auld@adic.com, linuxppc-embedded@lists.linuxppc.org
Subject: Re: PowerMac vs. Intel for PowerPC Development Host
Message-ID: <20030220194029.GB9782@host109.fsmlabs.com>
References: <995FF289C9D69747A09E42992644595405B23678@penguin.adic.com> <20030220010112.GB22880@f00f.org> <15956.11756.925757.532452@argo.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <15956.11756.925757.532452@argo.ozlabs.ibm.com>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


A $600 Dell 1.8GHz builds the 2_4_devel 440 kernel in 2m 45s.  That's just
great for our users.  The x86's are getting cheaper and faster, too.

However, we do use the native builds for some whacky packages (like X) that
are never going to cross-build properly.

} As an actual data point: my measurements show that a dual 1GHz G4
} powermac is more than twice as fast at compiling PPC kernels as a
} 1.7GHz P4 (single cpu).
}
} You can't fairly compare compiling a PPC kernel on a PPC box with
} compiling an x86 kernel on an x86 box.  GCC does more work compiling
} for PPC than for x86.
}
} Paul.
}

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
