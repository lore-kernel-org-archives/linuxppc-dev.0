Subject: 405GP cat /proc/interrupts
To: linuxppc-embedded@lists.linuxppc.org
Message-ID: <OF8E67EA1A.B526D51D-ON85256AED.0064781F@raleigh.ibm.com>
From: "John F Davis" <johndavi@us.ibm.com>
Date: Mon, 22 Oct 2001 14:24:44 -0400
MIME-Version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hello

I am using linux kernel 2.4.2_hhl20 (pre 2.0 CDK) with a custom modified
arch/ppc/kernel/ppc4xx_pic.c so that
it uses level, positive interrupts.  Note, I have tweaked the mtdcr calls
so it modifies UIC0_PR, TR, and CR to match
our hardware.  With that said, why does cat /proc/interrupts say that I am
using Edge Sensitive interrupts when I have
modified the TR register to be Level sensitive?

I am asking this, because I have a problem where I am missing interrupts
when they are generated quickly.  I am hoping that
the /proc/interrupts mismatch is a clue that I have not completed the Edge
to Level interrupt modification.  If you know of a file
besides ppc4xx_pic.c which needs to be modified, please let me know.

John


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
