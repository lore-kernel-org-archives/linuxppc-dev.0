Message-ID: <39CC3D55.74CD42A2@wanadoo.fr>
Date: Sat, 23 Sep 2000 07:19:17 +0200
From: Martin Costabel <costabel@wanadoo.fr>
MIME-Version: 1.0
To: linuxppc-dev@lists.linuxppc.org
Subject: Re: Re; 2.4.0-test9 on B&W G3
References: <20000922164705.32547@mail.mipsys.com> <39CBAA3C.2CC16A34@wanadoo.fr>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Martin Costabel wrote:

> Glad to hear that the linuxppc_2_3 bk tree is not dead. I was just going
> to ask about it, because since 2 weeks it has remained at -test8 which
> is feared for its terrible mailbox-eating habits.
>
> On the other hand, I am running a kernel obtained from this tree by
> applying just the "official" test9-pre1 patch, and I have now an uptime
> of 4 days, 22:02. This is the longest uptime I ever had with a 2.3/4
> kernel. No spontaneous freezes so far <knocking on wood>.

OK, I asked for it: As of right now, the bk linux_2_3 bk tree is at
2.4.0-test9-pre4. It is less dangerous than -test8 insofar as it doesn't
boot :-)

It compiles if one upgrades arch/ppc/kernel/time.c to, for example, the
one from Paul's linux-pmac-devel tree.

But it doesn't recognize my SCSI disk. I think it's a feature of
-test9-pre4 that SCSI is broken. This is patched in pre5 or pre6. So
I'll wait or use Paul's drivers/scsi directory...

--
Martin

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
