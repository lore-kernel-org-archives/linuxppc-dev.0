Date: Fri, 3 Mar 2000 15:07:26 -0700
From: Cort Dougan <cort@fsmlabs.com>
To: Dan Malek <dmalek@jlc.net>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>, Gary Thomas <gdt@linuxppc.org>,
        Paul Mackerras <paulus@linuxcare.com>,
        Linux/PPC Developer list <linuxppc-dev@lists.linuxppc.org>
Subject: Re: insw/outsw in ide.h
Message-ID: <20000303150726.I24528@medea.fsmlabs.com>
References: <Pine.GSO.4.10.10003031038210.20923-100000@dandelion.sonytel.be> <38C0304A.94A91C2F@jlc.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <38C0304A.94A91C2F@jlc.net>; from Dan Malek on Fri, Mar 03, 2000 at 04:36:10PM -0500
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


} Can I also have md.ide_*() for interrupts as well?  Please :-).
} On embedded processors we have internal interrupt controllers
} that require different initialization and ack'ing than the assumed
} 8259 type controllers.

You want ppc_md.ide_{insl,outsl} and so on?

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
