Date: Thu, 23 Mar 2000 14:45:36 -0700
From: Cort Dougan <cort@fsmlabs.com>
To: Pavel Roskin <pavel_roskin@geocities.com>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: Disabling interrupts
Message-ID: <20000323144536.J11342@medea.fsmlabs.com>
References: <Pine.LNX.4.21.0003231641120.31824-100000@sunapee.transcept.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <Pine.LNX.4.21.0003231641120.31824-100000@sunapee.transcept.com>; from Pavel Roskin on Thu, Mar 23, 2000 at 04:50:05PM -0500
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Does it have to be a user mode piece of code?  You're going to have real
trouble figuring that out if so.  Could you put that small portion of code
into a kernel module and just load it from your user program to do what it
needs to?

What is it you're trying to do that shouldn't be interrupted?

} I need to disable interrupts for a short time from a user program on
} RPX/Lite. This needs to be done only once, but it's absolutely essential
} that the program is not interrupted during a certain period of time.
}
} Using the __cli() function from the kernel sources in a user-space program
} doesn't work. The first instruction "mfmsr %r0" (Get current interrupt
} state) causes SIGILL.
}
} Probably I could hack the kernel to make processes with very high priority
} uninterruptible.
}
} I'm quite sure that the problem is not new. Anybody has a better idea?
}
} Pavel Roskin
}
}

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
