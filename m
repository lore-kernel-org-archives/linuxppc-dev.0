Message-ID: <20000203214854.24844.qmail@web205.mail.yahoo.com>
Date: Thu, 3 Feb 2000 13:48:54 -0800 (PST)
From: "D.J. Barrow" <barrow_dj@yahoo.com>
Subject: Re P600 vs G4 400Mhz.
To: linuxppc-dev <linuxppc-dev@lists.linuxppc.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


One thing I personally would be very intrested in
knowing is how much does our having to make fake page
table entries  hack slows us down as the powerpc
hardware under the hood uses a hash table & how much
work would it be to alter the memory managment page
middle dir api's etc. to use a truly architecture
independent page management system like the mach
microkernel ( rather than Linus'es idea of
architecture independence being 386 486 & pentium ).

Also has anyone checked how much faster the code
Metrowerks produces is from using it on the Mac I can
safely say that it is better than gcc on powerpc.

Also as pointed out by a colleague of mine at work
we "cheat" on the bogomips calculation according to
him
the rules state that 2 instructions should be used
to do this loop not one as we do with the bdnz trick.
However owing to our zero cycle branch prediction we
should ( I'd hope ) be still able to achieve the high
bogomips value.

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
