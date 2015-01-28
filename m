Return-Path: <naveen.n.rao@linux.vnet.ibm.com>
Received: from e28smtp03.in.ibm.com (e28smtp03.in.ibm.com [122.248.162.3])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id E1E6F1A0BD3
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 28 Jan 2015 17:43:30 +1100 (AEDT)
Received: from /spool/local
 by e28smtp03.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <naveen.n.rao@linux.vnet.ibm.com>;
 Wed, 28 Jan 2015 12:13:26 +0530
Received: from d28relay04.in.ibm.com (d28relay04.in.ibm.com [9.184.220.61])
 by d28dlp01.in.ibm.com (Postfix) with ESMTP id 59E9EE0045
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 28 Jan 2015 12:14:45 +0530 (IST)
Received: from d28av01.in.ibm.com (d28av01.in.ibm.com [9.184.220.63])
 by d28relay04.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t0S6hNIL62128372
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 28 Jan 2015 12:13:23 +0530
Received: from d28av01.in.ibm.com (localhost [127.0.0.1])
 by d28av01.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t0S6hMDd021733
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 28 Jan 2015 12:13:23 +0530
Date: Wed, 28 Jan 2015 12:13:02 +0530
From: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
To: Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: [PATCHv2 0/8] Fix perf probe issues on powerpc
Message-ID: <20150128064302.GB2078@naverao1-tp.in.ibm.com>
References: <cover.1418654435.git.naveen.n.rao@linux.vnet.ibm.com>
 <20150128054245.GA2078@naverao1-tp.in.ibm.com>
 <1422425662.11009.3.camel@ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1422425662.11009.3.camel@ellerman.id.au>
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

On 2015/01/28 05:14PM, Michael Ellerman wrote:
> On Wed, 2015-01-28 at 11:12 +0530, Naveen N. Rao wrote:
> > On 2014/12/15 08:20PM, Naveen N Rao wrote:
> > > This patchset fixes various issues with perf probe on powerpc across ABIv1 and
> > > ABIv2:
> > > - in the presence of DWARF debug-info,
> > > - in the absence of DWARF, but with the symbol table, and
> > > - in the absence of debug-info, but with kallsyms.
> > > 
> > > Applies cleanly on -tip. Tested on ppc64 BE and LE.
> > > 
> > > Changes from previous version:
> > > Addressed various review comments from Mike Ellerman largely to generalize
> > > changes. Some of the simpler patches have been retained in their previous form
> > > to limit code churn, while others have been generalized by introducing arch
> > > helpers. Individual patches have more details.
> > 
> > Michael,
> > Can you please take a quick look at this?
> 
> I merged patch 1.
> 
> https://git.kernel.org/cgit/linux/kernel/git/mpe/linux.git/commit/?h=next&id=bf794bf52a80c6278a028f0af2ca32d7c3508c9b
> 
> The rest are not for me, they're perf tools, so you need to convince acme
> they're good.

Oh, thanks! Sorry, I didn't realize you had already merged it.
I assume you are ok with my changes in v2 w.r.t your previous review 
comments.

Arnaldo,
Please have a look at this revision and let me know if you have any 
other concerns. Also, I have missed including Ananth's "Reviewed-by" in 
this patchset.  I'm guessing Ananth is ok with this revision as well.


- Naveen
