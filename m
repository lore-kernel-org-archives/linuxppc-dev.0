Return-Path: <mpe@ellerman.id.au>
Message-ID: <1386125416.2602.1.camel@concordia>
Subject: Re: [V3 00/10] perf: New conditional branch filter
From: Michael Ellerman <mpe@ellerman.id.au>
To: Anshuman Khandual <khandual@linux.vnet.ibm.com>
Date: Wed, 04 Dec 2013 13:50:16 +1100
In-Reply-To: <1381906617-11392-1-git-send-email-khandual@linux.vnet.ibm.com>
References: <1381906617-11392-1-git-send-email-khandual@linux.vnet.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: mikey@neuling.org, linux-kernel@vger.kernel.org, eranian@google.com,
 linuxppc-dev@ozlabs.org, Arnaldo Carvalho de Melo <acme@ghostprotocols.net>,
 sukadev@linux.vnet.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2013-10-16 at 12:26 +0530, Anshuman Khandual wrote:
> 		This patchset is the re-spin of the original branch stack sampling
> patchset which introduced new PERF_SAMPLE_BRANCH_COND branch filter. This patchset
> also enables SW based branch filtering support for book3s powerpc platforms which
> have PMU HW backed branch stack sampling support. 
> 
> Summary of code changes in this patchset:
> 
> (1) Introduces a new PERF_SAMPLE_BRANCH_COND branch filter
> (2) Add the "cond" branch filter options in the "perf record" tool
> (3) Enable PERF_SAMPLE_BRANCH_COND in X86 platforms
> (4) Enable PERF_SAMPLE_BRANCH_COND in POWER8 platform 
> (5) Update the documentation regarding "perf record" tool

Can you please address my comments and then resend patches 1-5. And make sure
you send them to the perf maintainers.

Those three touch the generic code, powerpc and x86, so we'll get those merged
first, and then focus on the remaining patches, which are powerpc specific.

cheers
