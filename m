From: "Taylor Holliday" <wtholliday@ucdavis.edu>
To: "linuxppc-dev" <linuxppc-dev@lists.linuxppc.org>
Subject: RE: quad 604 SMP
Date: Mon, 22 Jan 2001 18:59:30 -0800
Message-ID: <BHEOKMKGNHLELMKKJJIGIECPCAAA.wtholliday@ucdavis.edu>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
In-Reply-To: <19341209162022.2093@smtp.wanadoo.fr>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


I recently compiled the bk linuxppc_2_4 tree (2.4.1-pre9), noticing BenH
made some changes to /arch/ppc/kernel/smp.c.

I get 4 penguins but the kernel dies right after the "freeing unused kernel
memory" line

the oops message is:
Oops: kernel access of bad area, sig: 11
TASK = c01fa4c0[0] 'swapper' Last syscall: 120

Well that's an improvement over the previous situ - where it just would
hang.

Recompiling the kernel w/o SMP creates a fully functional kernel.

ideas?

thanks
- Taylor


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
