Return-Path: <muriloo@linux.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41W2TM5SWPzF35L
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 19 Jul 2018 02:21:27 +1000 (AEST)
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w6IGJ6Cp147393
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 18 Jul 2018 12:21:25 -0400
Received: from e33.co.us.ibm.com (e33.co.us.ibm.com [32.97.110.151])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2ka6w3p9xq-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 18 Jul 2018 12:21:25 -0400
Received: from localhost
 by e33.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <muriloo@linux.ibm.com>;
 Wed, 18 Jul 2018 10:21:24 -0600
Date: Wed, 18 Jul 2018 13:21:16 -0300
From: Murilo Opsfelder Araujo <muriloo@linux.ibm.com>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: linux-kernel@vger.kernel.org,
 "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>,
 Kees Cook <keescook@chromium.org>, Mathieu Malaterre <malat@debian.org>,
 Bharata B Rao <bharata@linux.vnet.ibm.com>,
 Nicholas Piggin <npiggin@gmail.com>, Alexey Kardashevskiy <aik@ozlabs.ru>,
 Michael Bringmann <mwb@linux.vnet.ibm.com>,
 Paul Mackerras <paulus@samba.org>,
 =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>,
 Nathan Fontenot <nfont@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH] powerpc/prom_init: remove linux,stdout-package property
References: <20180712171904.18971-1-muriloo@linux.ibm.com>
 <87a7qoq3z2.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <87a7qoq3z2.fsf@concordia.ellerman.id.au>
Message-Id: <20180718162116.GA24748@kermit-br-ibm-com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Jul 18, 2018 at 07:37:37PM +1000, Michael Ellerman wrote:
> Hi Murilo,
> 
> Thanks for the patch.
> 
> Murilo Opsfelder Araujo <muriloo@linux.ibm.com> writes:
> > This property was added in 2004 by
> >
> >     https://github.com/mpe/linux-fullhistory/commit/689fe5072fe9a0dec914bfa4fa60aed1e54563e6
> >
> > and the only use of it, which was already inside `#if 0`, was removed a month
> > later by
> >
> >     https://github.com/mpe/linux-fullhistory/commit/1fbe5a6d90f6cd4ea610737ef488719d1a875de7
> >
> > Fixes: https://github.com/linuxppc/linux/issues/125
> 
> That is going to confuse some scripts that are expecting that to be a
> "Fixes: <some commit>" tag :)
> 
> The proper tag to use there would be "Link:".
> 
> But, I'd prefer we didn't add github issue links to the history, as I'm
> not sure they won't bit-rot eventually. Not because I'm a anti-Microsoft
> conspiracy person but just because it's a repo I set up and manage and
> there's no long term plan for it necessarily.
> 
> > ---
> >  arch/powerpc/kernel/prom_init.c | 2 --
> >  1 file changed, 2 deletions(-)
> 
> Including the link here would be ideal, as it means it doesn't end up in
> the commit history, but it does end up in the mail archive. So if we
> ever really need to find it, it should be there.
> 
> cheers

Hi, Michael.

Thanks for reviewing it.  I've sent v2 with your suggestions:

    https://lkml.kernel.org/r/20180718161544.12134-1-muriloo@linux.ibm.com

Cheers

--
Murilo
