Message-ID: <37FEA5CA.57808DB3@mvista.com>
Date: Fri, 08 Oct 1999 21:17:47 -0500
From: Jim Lewis <jlewis@mvista.com>
MIME-Version: 1.0
To: linuxppc-embedded <linuxppc-embedded@lists.linuxppc.org>
Subject: Strange behavior on FADS with ICTRL==0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hello,

I am working with 2.2.5 on a FADS 823. If the ISCT_SER field of the
ICTRL register is set to 0 (which is the value on reset), the system is
very unstable. This field controls whether the core is serialized and
provides options for placing instruction fetches from cache on the
external pins for tracing and debugging purposes.  Mainly, I get one of
two errors after init has started:
    Panic: Kernel Mode Software FPU Emulation
    page fault in interrupt handler
When ISCT_SER is set to 0, the core is fully serialized and all
instruction fetches are shown. On the other hand, if I set the ISCT_SER
to 7 (the recommended "production" value), the core is not serialized
and no fetches are shown. The system is stable with this setting.

Has anyone else experienced anything like this?

Thanks
--
Jim Lewis
Sr. Field Applications Engineer
MontaVista Software, Inc.
(817)261-9088 http://www.mvista.com


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
