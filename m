From: Benjamin Herrenschmidt <bh40@calva.net>
To: Eric Reischer <reischer@psu.edu>,
        Jonathan Lane
 <jingai@shell.faradic.net>,
        <linuxppc-dev@lists.linuxppc.org>
Subject: Re: 3COM 3c905c again
Date: Wed, 6 Dec 2000 23:00:12 +0100
Message-Id: <19341031153156.10971@192.168.1.10>
In-Reply-To: <4.2.0.58.20001203235133.009a3620@engr.de.psu.edu>
References: <4.2.0.58.20001203235133.009a3620@engr.de.psu.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


>>Okay, I swapped cards around, and it turns out that *anything* in
>>PCI slots 3-6 are not correctly configured (this is on a UMAX S900).
>>I moved the USB card and NIC to slots 1 and 2, and my video card
>>to slot 4, which appears to be working (although I've not tried
>>using X yet, as XF86 4.0.1 is currently broken...).

This might work better with current bitkeeper _2_3 kernels (currently
at 2.4test12-pre-something). There's some new PCI code there that should
handle multiple PCI busses more gracefully.

Ben.

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
