Message-ID: <47EE8DCFB8C6D311A23700508B8BAD5903DB07@THEBRAIN2>
From: "Karaaslan, Utku" <UKaraasl@drs.ca>
To: "'linuxppc-embedded@lists.linuxppc.org'" <linuxppc-embedded@lists.linuxppc.org>
Subject: A Question on QSPAN-II
Date: Tue, 14 Aug 2001 18:33:46 -0400
MIME-Version: 1.0
Content-Type: text/plain
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hello All,

I have my Ppcboot (version 0.8.3) running on my custom board, and the Linux
kernel version I am using is
2.4.1-pre7. Scanning the PCI bus is a walk in the park with the Ppcboot, but
the Linux kernel doesn't see
any devices on it during the PCI scanning functions. I have added the
ioremap entry to accomodate the Qspan-II
register image, so the physical access under linux shouldn't be a problem,
however I still cannot see any
devices when the kernel is running. Would you have any ideas on why this
could happen - and how I could correct
it?

Many thanks in advance,

Utku

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
