Date: Mon, 7 Jun 1999 10:54:17 +0200 (CEST)
From: Alexander Larsson <alex@signum.se>
To: dmalek@jlc.net, linuxppc-dev@lists.linuxppc.org
Subject: Bug report
Message-ID: <Pine.LNX.4.04.9906071049580.26155-100000@tammy.signum.se>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


In the embedded 2.2.5 sources i found the following in
arch/ppc/kernel/ppc-stub.c


static inline void set_msr(int msr)
{
	asm volatile("mfmsr %0" : : "r" (msr));
}

Shouldn't that be mtmsr?

/ Alex


[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
