Return-Path: <htejun@gmail.com>
Received: from mail-qc0-f182.google.com (mail-qc0-f182.google.com
 [209.85.216.182])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 795AD2C0098
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 29 Jan 2013 06:06:29 +1100 (EST)
Received: by mail-qc0-f182.google.com with SMTP id k19so1437070qcs.41
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 28 Jan 2013 11:06:26 -0800 (PST)
MIME-Version: 1.0
Sender: htejun@gmail.com
In-Reply-To: <CAA_GA1fSLNKSDTGSzHoA+j-mur85BvoSRkARq+DMfORuwrrX4Q@mail.gmail.com>
References: <20130122073210.13822.50434.stgit@srivatsabhat.in.ibm.com>
 <20130122074123.13822.39102.stgit@srivatsabhat.in.ibm.com>
 <CAA_GA1fSLNKSDTGSzHoA+j-mur85BvoSRkARq+DMfORuwrrX4Q@mail.gmail.com>
Date: Mon, 28 Jan 2013 11:06:25 -0800
Message-ID: <CAOS58YN_r-ahRvPekOo_84bM7z3YcFw1EA7DcTf0NVyEhv7ssA@mail.gmail.com>
Subject: Re: [PATCH v5 31/45] blackfin/smp: Use get/put_online_cpus_atomic()
 to prevent CPU offline
From: Tejun Heo <tj@kernel.org>
To: Bob Liu <lliubbo@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linux-doc@vger.kernel.org, peterz@infradead.org, fweisbec@gmail.com,
 linux-kernel@vger.kernel.org, mingo@kernel.org, linux-arch@vger.kernel.org,
 linux@arm.linux.org.uk, xiaoguangrong@linux.vnet.ibm.com,
 wangyun@linux.vnet.ibm.com, paulmck@linux.vnet.ibm.com,
 nikunj@linux.vnet.ibm.com, linux-pm@vger.kernel.org, rusty@rustcorp.com.au,
 rostedt@goodmis.org, rjw@sisk.pl, namhyung@kernel.org, tglx@linutronix.de,
 linux-arm-kernel@lists.infradead.org, netdev@vger.kernel.org, oleg@redhat.com,
 sbw@mit.edu, "Srivatsa S. Bhat" <srivatsa.bhat@linux.vnet.ibm.com>,
 akpm@linux-foundation.org, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hello, Bob.

On Mon, Jan 28, 2013 at 1:09 AM, Bob Liu <lliubbo@gmail.com> wrote:
> Thanks, will be applied to my blackfin arch tree.

I think we still have some work ahead of us to have this patchset
ready for inclusion and even then it probably would be best to route
these patches together, so probably not a very good idea to apply this
to blackfin right now.

Thanks.

-- 
tejun
