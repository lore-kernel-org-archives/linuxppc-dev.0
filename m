From: Keith Owens <kaos@ocs.com.au>
To: paulus@linuxcare.com.au
cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: [RFC] 2.4.0-test6-pre2 Merge softirq, local_irq_count, local_bh_count 
In-reply-to: Your message of "Sat, 05 Aug 2000 17:14:36 +1000."
             <14731.48860.794336.528961@argo.linuxcare.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Sat, 05 Aug 2000 17:37:14 +1000
Message-ID: <28786.965461034@ocs3.ocs-net>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Sat, 5 Aug 2000 17:14:36 +1000 (EST),
Paul Mackerras <paulus@linuxcare.com.au> wrote:
>Seems to work ok on uniprocessor PPC.  The 2.4 kernels have problems
>on SMP PPC boxes at the moment so I haven't tested it on SMP.

Thanks for that.  Linus rolled the patch into 2.4.0-test6-pre4.

>Have you done any measurements, with lmbench or whatever, to measure
>how much performance improvement you get with the patch?

No, it was not really driven by performance considerations.  SGI wanted
to add a syscall count for performance and fail over monitoring.  Linus
said he would accept the syscall count if we cleaned up softirq at the
same time, instead of having two statistic cache lines per cpu.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
