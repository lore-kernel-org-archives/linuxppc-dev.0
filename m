Date: Tue, 25 May 2004 09:12:10 -0400 (EDT)
From: "Robert P. J. Day" <rpjday@mindspring.com>
To: Embedded Linux PPC list <linuxppc-embedded@lists.linuxppc.org>
Subject: curious about BK checkin protocol
Message-ID: <Pine.LNX.4.58.0405250909280.14496@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


  i just bk-cloned a fresh copy of the source tree from
http://ppc.bkbits.net:8080/linuxppc-2.5, and once again, had to fix the
file arch/ppc/kernel/ppc_ksyms.c to remove the now-obsolete snippet of
code:

#if defined(CONFIG_8xx)
EXPORT_SYMBOL(request_8xxirq);
#endif

  i thought it had been well-established by now that this had to go.
what's the protocol for someone putting these changes into the tree?
just curious.

rday

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
