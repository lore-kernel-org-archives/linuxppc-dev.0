Message-ID: <A33AEFDC2EC0D411851900D0B73EBEF7262672@NAPA>
From: Hua Ji <hji@netscreen.com>
To: linuxppc-embedded@lists.linuxppc.org
Subject: About PPC page table
Date: Mon, 19 Mar 2001 16:17:49 -0800
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>




Hi, folks,

A quick question today. Thanks in advance.

For PowerPC, say, 750 architecture, does every process maintains its own
page table?
>From documents, Looks like the system will only maintain one page table
space, pointed by **SDR1*** register.
Am I correct? Looks to me, this is very different from the two level page
directory in x86 architecture.

>From powerpc manual, a 2M space needed to be reserved for mapping 256M
physical memory. So, if every process maintain its own page table, that
would be cost too much and is not feasible, from my view.

My current thought is:

* All system only have one page table area.
* All PTE entry updating/deleting will operating on the predefined page
table area, by using primary hash and second hash functions.

* Every process will maintain its own VSID(closely related to its PID). So,
when do the context switch, the
all **segment registers** will be saveed and updated?

Please let me know if you can help me clearify my ideas. Thanks in advance,

Mike

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
