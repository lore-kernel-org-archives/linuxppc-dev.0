Return-Path: <milian.wolff@kdab.com>
Received: from mail.kdab.com (mail.kdab.com [176.9.126.58])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wsyHR6vFlzDq88
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 21 Jun 2017 18:17:07 +1000 (AEST)
Sender: milian
From: Milian Wolff <milian.wolff@kdab.com>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>,
 Mark Wielaard <mark@klomp.org>, Paolo Bonzini <pbonzini@redhat.com>,
 linux-kernel@vger.kernel.org,
 "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>,
 linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v2] perf: libdw support for powerpc [ping]
Date: Wed, 21 Jun 2017 10:16:56 +0200
Message-ID: <1632232.7qGxppV1HK@agathebauer>
In-Reply-To: <20170621010739.GL13640@kernel.org>
References: <1496312681-20133-1-git-send-email-pbonzini@redhat.com>
 <3621613.kMnvz8Tm3d@milian-kdab2> <20170621010739.GL13640@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mittwoch, 21. Juni 2017 03:07:39 CEST Arnaldo Carvalho de Melo wrote:
> Em Thu, Jun 15, 2017 at 10:46:16AM +0200, Milian Wolff escreveu:
> > On Tuesday, June 13, 2017 5:55:09 PM CEST Ravi Bangoria wrote:
> > Just a quick question: Have you guys applied my recent patch:
> > 
> > commit 5ea0416f51cc93436bbe497c62ab49fd9cb245b6
> > Author: Milian Wolff <milian.wolff@kdab.com>
> > Date:   Thu Jun 1 23:00:21 2017 +0200
> > 
> >     perf report: Include partial stacks unwound with libdw
> >     
> >     So far the whole stack was thrown away when any error occurred before
> >     the maximum stack depth was unwound. This is actually a very common
> >     scenario though. The stacks that got unwound so far are still
> >     interesting. This removes a large chunk of differences when comparing
> >     perf script output for libunwind and libdw perf unwinding.
> > 
> > If not, then this could explain the issue you are seeing.
> 
> Hi Millian, can I take this as an Acked-by or Tested-by?

I have no access to any PowerPC hardware. In principle the code looks fine, 
but that's all I can say here.

Cheers

-- 
Milian Wolff | milian.wolff@kdab.com | Senior Software Engineer
KDAB (Deutschland) GmbH&Co KG, a KDAB Group company
Tel: +49-30-521325470
KDAB - The Qt Experts
