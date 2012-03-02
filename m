Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id C69391007D3
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  3 Mar 2012 08:52:28 +1100 (EST)
Message-ID: <1330725132.11728.52.camel@pasglop>
Subject: Re: linux-next: boot failure for next-20120227 and later (pci tree
 related)
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Bjorn Helgaas <bhelgaas@google.com>
Date: Sat, 03 Mar 2012 08:52:12 +1100
In-Reply-To: <CAErSpo6xQa4Rnv+RkkXCRjQ2HDZdBhorRv2c6pmWyXqRzhM4Vw@mail.gmail.com>
References: <20120302170638.3d172369d04335d9b921a28c@canb.auug.org.au>
 <CAErSpo6xQa4Rnv+RkkXCRjQ2HDZdBhorRv2c6pmWyXqRzhM4Vw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, linux-next@vger.kernel.org,
 ppc-dev <linuxppc-dev@lists.ozlabs.org>, linux-kernel@vger.kernel.org,
 Jesse Barnes <jbarnes@virtuousgeek.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2012-03-02 at 10:10 -0700, Bjorn Helgaas wrote:
> On Thu, Mar 1, 2012 at 11:06 PM, Stephen Rothwell <sfr@canb.auug.org.au> wrote:
> > Hi Jesse,
> >
> > Staring with next-20120227, one of my boot tests is failing like this:
> 
> Hi Stephen,
> 
> Thanks a lot for the test report and the bisection.  I wish I had a
> machine to test on so I wouldn't have to bother you about it.
> 
> Any chance you could point me at the complete before/after dmesg logs?
>  There should be information about the PCI host bridge apertures and
> offsets in the "after" log.  If that's not enough, we might need to
> collect new before/after logs with something like this
> (whitespace-mangled):

Or give me a chance to dig :-) I'll have a look next week.

Cheers,
Ben.
