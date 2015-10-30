Return-Path: <scottwood@freescale.com>
Received: from na01-by2-obe.outbound.protection.outlook.com
 (mail-by2on0148.outbound.protection.outlook.com [207.46.100.148])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id E46D91A0A9E
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 31 Oct 2015 06:45:18 +1100 (AEDT)
Message-ID: <1446234303.22185.38.camel@freescale.com>
Subject: Re: [ANNOUNCE] kexec-tools 2.0.11-rc1
From: Scott Wood <scottwood@freescale.com>
To: Simon Horman <horms@verge.net.au>
CC: <kexec@lists.infradead.org>, Michael Ellerman <mpe@ellerman.id.au>,
 <linuxppc-dev@lists.ozlabs.org>, Samuel Mendoza-Jonas <sam.mj@au1.ibm.com>
Date: Fri, 30 Oct 2015 14:45:03 -0500
In-Reply-To: <20151030081236.GH31252@verge.net.au>
References: <20151029234849.GA28689@verge.net.au>
 <1446164604.22185.19.camel@freescale.com>
 <20151030081236.GH31252@verge.net.au>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2015-10-30 at 17:12 +0900, Simon Horman wrote:
> On Thu, Oct 29, 2015 at 07:23:24PM -0500, Scott Wood wrote:
> > On Fri, 2015-10-30 at 08:48 +0900, Simon Horman wrote:
> > > Hi all,
> > > 
> > > I am happy to announce the release of kexec-tools 2.0.11-rc1.
> > > 
> > > This is an incremental feature pre-release.
> > > 
> > > So long as no serious problems arise I intend to release kexec-tools 
> > > 2.0.11
> > > shortly after the release of the v4.3 kernel, which I expect to occur in
> > > the next week or so.  As such testing of 2.0.11-rc1 would be greatly
> > > appreciated.
> > > 
> > > I do not have any outstanding changes for 2.0.11 at this time.
> > > And I would like to only accept bug fixes at this time and take take
> > > features patches once 2.0.11 has been released.
> > 
> > As I previously reported, "ppc64: purgatory: Reset primary cpu endian to 
> > big-
> > endian" breaks book3e, so can  http://patchwork.ozlabs.org/patch/527048/be 
> > considered for this release?
> 
> Yes of course, sorry for not taking more note of that.
> 
> Would it be possible to get a review, e.g. from Michael?

I pinged Michael again on the original patch, and CCed him and Samuel and the 
PPC list here.  If they still don't respond, and you still don't want to put 
the fix in without their input, then could you revert the broken patch?

-Scott
