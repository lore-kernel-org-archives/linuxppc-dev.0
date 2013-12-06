Return-Path: <arnaldo.melo@gmail.com>
Received: from mail-qe0-x236.google.com (mail-qe0-x236.google.com
 [IPv6:2607:f8b0:400d:c02::236])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com",
 Issuer "Google Internet Authority G2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 24E8A2C00A7
 for <linuxppc-dev@ozlabs.org>; Sat,  7 Dec 2013 00:18:26 +1100 (EST)
Received: by mail-qe0-f54.google.com with SMTP id cy11so456901qeb.41
 for <linuxppc-dev@ozlabs.org>; Fri, 06 Dec 2013 05:18:24 -0800 (PST)
Sender: Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
Date: Fri, 6 Dec 2013 10:18:17 -0300
From: Arnaldo Carvalho de Melo <acme@ghostprotocols.net>
To: Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: [PATCH V4 00/10] perf: New conditional branch filter
Message-ID: <20131206131817.GB2279@ghostprotocols.net>
References: <1386153162-11225-1-git-send-email-khandual@linux.vnet.ibm.com>
 <1386218874.6009.7.camel@concordia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1386218874.6009.7.camel@concordia>
Cc: mikey@neuling.org, ak@linux.intel.com, linux-kernel@vger.kernel.org,
 eranian@google.com, linuxppc-dev@ozlabs.org, sukadev@linux.vnet.ibm.com,
 mingo@kernel.org, Anshuman Khandual <khandual@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Em Thu, Dec 05, 2013 at 03:47:54PM +1100, Michael Ellerman escreveu:
> On Wed, 2013-12-04 at 16:02 +0530, Anshuman Khandual wrote:
> > 		This patchset is the re-spin of the original branch stack sampling
> > patchset which introduced new PERF_SAMPLE_BRANCH_COND branch filter. This patchset
> > also enables SW based branch filtering support for book3s powerpc platforms which
> > have PMU HW backed branch stack sampling support. 
> > 
> > Summary of code changes in this patchset:
> > 
> > (1) Introduces a new PERF_SAMPLE_BRANCH_COND branch filter
> > (2) Add the "cond" branch filter options in the "perf record" tool
> > (3) Enable PERF_SAMPLE_BRANCH_COND in X86 platforms
> > (4) Enable PERF_SAMPLE_BRANCH_COND in POWER8 platform 
> > (5) Update the documentation regarding "perf record" tool
> 
> 
> Hi Arnaldo,
> 
> Can you please take just patches 1-5 into the perf tree? And do you mind
> putting them in a topic branch so Benh can merge that.

This is mostly kernel code, I process the userspace ones, so I think either
Ingo or PeterZ should pick these, Ingo, Peter?

Only:

Subject: [PATCH V4 03/10] perf, tool: Conditional branch filter 'cond' added to perf record

Which is a one liner, touches tools/perf/, and I'm ok with it.


- Arnaldo
 
> The remaining patches are powerpc specific and still need some more review.
> 
> cheers
> 
