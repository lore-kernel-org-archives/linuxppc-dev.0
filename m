Date: Thu, 29 Jul 2004 13:36:57 -0400 (EDT)
From: "Robert P. J. Day" <rpjday@mindspring.com>
To: Embedded Linux PPC list <linuxppc-embedded@lists.linuxppc.org>
Subject: yee ha.  SMC1 relocation working under 2.6.
Message-ID: <Pine.LNX.4.60.0407291334130.21679@dell.enoriver.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


   based on a patch set that i got from torsten demke (thank you, mr.
demke), and incorporated into my patch set, i verified that i now have
SMC1 relocation.  hot diggety.  about to go for ethernet on SCC3.

rday

p.s.  previous patch i posted here had a stupid omission, forgot to
add a few critical lines to micropatch.c from torsten's patch, but
once that went in, the boot confirmed that SMC1 was now at 0x1FC0.
slowly, but surely ...

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
