Message-ID: <67505026E29DD311A9AA00508B7315F350A558@EXCHANGE>
From: Julia Elbert <jelbert@enerdyne.com>
To: "'Dan Malek'" <dan@mvista.com>,
        "'linuxppc-embedded@lists.linuxppc.org'"
	 <linuxppc-embedded@lists.linuxppc.org>
Subject: RE: CPM ENET: BSY can't happen.
Date: Wed, 18 Oct 2000 10:13:17 -0700
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi all,
I applied Jon's fix to commproc.c, but I am still getting kernel panic with
a

Scheduling in interrupt
page fault in interrupt handler, addr=0
NIP: C00157C0 XER: C000EA3C LR: C00157C0 REGS: c0db3bb0 TRAP: 0300
CPM ENET: BSY can't happen.
MSR: 00009032 EE: 1 PR: 0 FP: 0 ME: 1 IR/DR: 11
TASK = c0db2000[19] 'dec' mm->pgd c0f81000 Last syscall: 102
last math 00000000

Any ideas?
The CPM ENET: BSY msg I can ignore, but I can't help wondering if it is
another clue.

Thank you for all your knowledge.
--Julia


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
