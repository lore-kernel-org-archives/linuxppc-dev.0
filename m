Message-ID: <38C0304A.94A91C2F@jlc.net>
Date: Fri, 03 Mar 2000 16:36:10 -0500
From: Dan Malek <dmalek@jlc.net>
MIME-Version: 1.0
To: Geert Uytterhoeven <geert@linux-m68k.org>
CC: Cort Dougan <cort@fsmlabs.com>, Gary Thomas <gdt@linuxppc.org>,
        Paul Mackerras <paulus@linuxcare.com>,
        Linux/PPC Developer list <linuxppc-dev@lists.linuxppc.org>
Subject: Re: insw/outsw in ide.h
References: <Pine.GSO.4.10.10003031038210.20923-100000@dandelion.sonytel.be>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Geert Uytterhoeven wrote:


> BTW, I'm in favor of having ide_*()-ops for all accesses,....


Can I also have md.ide_*() for interrupts as well?  Please :-).
On embedded processors we have internal interrupt controllers
that require different initialization and ack'ing than the assumed
8259 type controllers.

Thanks.


	-- Dan

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
