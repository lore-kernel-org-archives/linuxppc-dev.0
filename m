Return-Path: <mpe@ellerman.id.au>
Message-ID: <1398741164.8217.6.camel@concordia>
Subject: Re: [PATCH v2 6/6] powerpc/perf/hv-24x7: catalog version number is
 be64, not be32
From: Michael Ellerman <mpe@ellerman.id.au>
To: Cody P Schafer <cody@linux.vnet.ibm.com>
Date: Tue, 29 Apr 2014 13:12:44 +1000
In-Reply-To: <535DE027.5050700@linux.vnet.ibm.com>
References: <1397581855-4585-1-git-send-email-cody@linux.vnet.ibm.com>
 <1397581855-4585-7-git-send-email-cody@linux.vnet.ibm.com>
 <1398660478.30694.10.camel@pasglop> <535DE027.5050700@linux.vnet.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: David.Laight@aculab.com, Linux PPC <linuxppc-dev@lists.ozlabs.org>,
 LKML <linux-kernel@vger.kernel.org>, Anton Blanchard <anton@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sun, 2014-04-27 at 21:59 -0700, Cody P Schafer wrote:
> On 04/27/2014 09:47 PM, Benjamin Herrenschmidt wrote:
> > On Tue, 2014-04-15 at 10:10 -0700, Cody P Schafer wrote:
> >> The catalog version number was changed from a be32 (with proceeding
> >> 32bits of padding) to a be64, update the code to treat it as a be64
> >>
> >> Signed-off-by: Cody P Schafer <cody@linux.vnet.ibm.com>
> >> --
> >
> > Have you tested this ?
> >
> > It doesn't build for me:
> >
> > arch/powerpc/perf/hv-24x7.c: In function 'catalog_read':
> > arch/powerpc/perf/hv-24x7.c:223:3: error: format '%d' expects argument of type 'int', but argument 2 has type 'uint64_t' [-Werror=format]
> > cc1: all warnings being treated as errors
> 
> I have, and I wasn't initially sure how I managed to miss that 
> warning-as-error. On examination: My config (for some reason) has 
> CONFIG_PPC_DISABLE_WERROR=y set (probably because it's a variation of a 
> distro config).

Please test build with ppc64_defconfig at least.

cheers
