Return-Path: <srivatsa.bhat@linux.vnet.ibm.com>
Received: from e28smtp05.in.ibm.com (e28smtp05.in.ibm.com [122.248.162.5])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e28smtp05.in.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id DA2122C008D
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 29 Jan 2013 12:16:11 +1100 (EST)
Received: from /spool/local
 by e28smtp05.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <srivatsa.bhat@linux.vnet.ibm.com>;
 Tue, 29 Jan 2013 06:44:40 +0530
Received: from d28relay05.in.ibm.com (d28relay05.in.ibm.com [9.184.220.62])
 by d28dlp02.in.ibm.com (Postfix) with ESMTP id 5CDE4394004C
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 29 Jan 2013 06:46:03 +0530 (IST)
Received: from d28av05.in.ibm.com (d28av05.in.ibm.com [9.184.220.67])
 by d28relay05.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r0T1G1Ta23527580
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 29 Jan 2013 06:46:01 +0530
Received: from d28av05.in.ibm.com (loopback [127.0.0.1])
 by d28av05.in.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r0T1G1V9015590
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 29 Jan 2013 12:16:03 +1100
Message-ID: <5107225A.5040702@linux.vnet.ibm.com>
Date: Tue, 29 Jan 2013 12:14:02 +1100
From: "Srivatsa S. Bhat" <srivatsa.bhat@linux.vnet.ibm.com>
MIME-Version: 1.0
To: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH v5 31/45] blackfin/smp: Use get/put_online_cpus_atomic()
 to prevent CPU offline
References: <20130122073210.13822.50434.stgit@srivatsabhat.in.ibm.com>
 <20130122074123.13822.39102.stgit@srivatsabhat.in.ibm.com>
 <CAA_GA1fSLNKSDTGSzHoA+j-mur85BvoSRkARq+DMfORuwrrX4Q@mail.gmail.com>
 <CAOS58YN_r-ahRvPekOo_84bM7z3YcFw1EA7DcTf0NVyEhv7ssA@mail.gmail.com>
In-Reply-To: <CAOS58YN_r-ahRvPekOo_84bM7z3YcFw1EA7DcTf0NVyEhv7ssA@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linux-doc@vger.kernel.org, peterz@infradead.org, fweisbec@gmail.com,
 linux-kernel@vger.kernel.org, mingo@kernel.org, linux-arch@vger.kernel.org,
 linux@arm.linux.org.uk, xiaoguangrong@linux.vnet.ibm.com,
 wangyun@linux.vnet.ibm.com, paulmck@linux.vnet.ibm.com,
 Bob Liu <lliubbo@gmail.com>, nikunj@linux.vnet.ibm.com,
 linux-pm@vger.kernel.org, rusty@rustcorp.com.au, rostedt@goodmis.org,
 rjw@sisk.pl, namhyung@kernel.org, tglx@linutronix.de,
 linux-arm-kernel@lists.infradead.org, netdev@vger.kernel.org, oleg@redhat.com,
 sbw@mit.edu, akpm@linux-foundation.org, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 01/29/2013 06:06 AM, Tejun Heo wrote:
> Hello, Bob.
> 
> On Mon, Jan 28, 2013 at 1:09 AM, Bob Liu <lliubbo@gmail.com> wrote:
>> Thanks, will be applied to my blackfin arch tree.
> 
> I think we still have some work ahead of us to have this patchset
> ready for inclusion and even then it probably would be best to route
> these patches together, so probably not a very good idea to apply this
> to blackfin right now.
> 

Thanks Tejun for pointing that out! I'll address the review comments
soon and respin the patchset.
 
Regards,
Srivatsa S. Bhat
