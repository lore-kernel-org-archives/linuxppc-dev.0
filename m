Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 0A5EB1A0021
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 30 Jan 2015 13:19:39 +1100 (AEDT)
Message-ID: <1422584378.13284.3.camel@ellerman.id.au>
Subject: Re: [PATCHv2 0/8] Fix perf probe issues on powerpc
From: Michael Ellerman <mpe@ellerman.id.au>
To: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
Date: Fri, 30 Jan 2015 13:19:38 +1100
In-Reply-To: <20150128064302.GB2078@naverao1-tp.in.ibm.com>
References: <cover.1418654435.git.naveen.n.rao@linux.vnet.ibm.com>
 <20150128054245.GA2078@naverao1-tp.in.ibm.com>
 <1422425662.11009.3.camel@ellerman.id.au>
 <20150128064302.GB2078@naverao1-tp.in.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 acme@kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2015-01-28 at 12:13 +0530, Naveen N. Rao wrote:
> On 2015/01/28 05:14PM, Michael Ellerman wrote:
> > On Wed, 2015-01-28 at 11:12 +0530, Naveen N. Rao wrote:
> > > On 2014/12/15 08:20PM, Naveen N Rao wrote:
> > > > This patchset fixes various issues with perf probe on powerpc across ABIv1 and
> > > > ABIv2:
> > > > - in the presence of DWARF debug-info,
> > > > - in the absence of DWARF, but with the symbol table, and
> > > > - in the absence of debug-info, but with kallsyms.
> > > > 
> > > > Applies cleanly on -tip. Tested on ppc64 BE and LE.
> > > > 
> > > > Changes from previous version:
> > > > Addressed various review comments from Mike Ellerman largely to generalize
> > > > changes. Some of the simpler patches have been retained in their previous form
> > > > to limit code churn, while others have been generalized by introducing arch
> > > > helpers. Individual patches have more details.
> > > 
> > > Michael,
> > > Can you please take a quick look at this?
> > 
> > I merged patch 1.
> > 
> > https://git.kernel.org/cgit/linux/kernel/git/mpe/linux.git/commit/?h=next&id=bf794bf52a80c6278a028f0af2ca32d7c3508c9b
> > 
> > The rest are not for me, they're perf tools, so you need to convince acme
> > they're good.
> 
> Oh, thanks! Sorry, I didn't realize you had already merged it.
> I assume you are ok with my changes in v2 w.r.t your previous review 
> comments.

Yeah it looks like you addressed most of my comments.

cheers
