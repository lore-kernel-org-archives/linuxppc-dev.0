From: Simon Winwood <sjw@cse.unsw.edu.au>
To: linuxppc-embedded@lists.linuxppc.org
Date: Wed, 21 Nov 2001 10:45:17 +1100
Subject: Walnut boottime issues
Message-ID: <20011121104517.A12111@cse.unsw.edu.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


	Hi, the latest bitkeeper linuxppc_2_4_devel kernel is broken
for walnut (and any other board using misc-embedded.c in arch/ppc/boot/simple)

	Specifically, the ZIMAGE_START and ZIMAGE_SIZE macros are wrong (0)
and have been replaced by {__image}_{begin, end}.

	The command line stuff also appears to be broken (the kernel doesn't
get the command line properly)

	Is there a fix pending, or should I do it?

	Simon

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
