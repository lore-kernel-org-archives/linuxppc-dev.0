From: Paul Mackerras <paulus@linuxcare.com.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <14731.48860.794336.528961@argo.linuxcare.com.au>
Date: Sat, 5 Aug 2000 17:14:36 +1000 (EST)
To: Keith Owens <kaos@ocs.com.au>
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: [RFC] 2.4.0-test6-pre2 Merge softirq, local_irq_count, local_bh_count 
In-Reply-To: <7892.965367999@ocs3.ocs-net>
References: <7892.965367999@ocs3.ocs-net>
Reply-To: paulus@linuxcare.com.au
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Keith Owens writes:

> This patch hits every arch.  It is being cross mailed to every arch
> mailing list that has not already confirmed that the patch works.
> Please trim replies to the relevant mailing list.

Seems to work ok on uniprocessor PPC.  The 2.4 kernels have problems
on SMP PPC boxes at the moment so I haven't tested it on SMP.

Have you done any measurements, with lmbench or whatever, to measure
how much performance improvement you get with the patch?

--
Paul Mackerras, Senior Open Source Researcher, Linuxcare, Inc.
+61 2 6262 8990 tel, +61 2 6262 8991 fax
paulus@linuxcare.com.au, http://www.linuxcare.com.au/
Linuxcare.  Support for the revolution.

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
