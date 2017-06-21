Return-Path: <acme@kernel.org>
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wsmm00QD4zDq8c
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 21 Jun 2017 11:07:44 +1000 (AEST)
Date: Tue, 20 Jun 2017 22:07:39 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Milian Wolff <milian.wolff@kdab.com>
Cc: Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>,
 Mark Wielaard <mark@klomp.org>, Paolo Bonzini <pbonzini@redhat.com>,
 linux-kernel@vger.kernel.org,
 "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>,
 linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v2] perf: libdw support for powerpc [ping]
Message-ID: <20170621010739.GL13640@kernel.org>
References: <1496312681-20133-1-git-send-email-pbonzini@redhat.com>
 <1497354282.3755.201.camel@klomp.org>
 <59400ADD.4090709@linux.vnet.ibm.com>
 <3621613.kMnvz8Tm3d@milian-kdab2>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <3621613.kMnvz8Tm3d@milian-kdab2>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Em Thu, Jun 15, 2017 at 10:46:16AM +0200, Milian Wolff escreveu:
> On Tuesday, June 13, 2017 5:55:09 PM CEST Ravi Bangoria wrote:
> Just a quick question: Have you guys applied my recent patch:
 
> commit 5ea0416f51cc93436bbe497c62ab49fd9cb245b6
> Author: Milian Wolff <milian.wolff@kdab.com>
> Date:   Thu Jun 1 23:00:21 2017 +0200
 
>     perf report: Include partial stacks unwound with libdw
     
>     So far the whole stack was thrown away when any error occurred before
>     the maximum stack depth was unwound. This is actually a very common
>     scenario though. The stacks that got unwound so far are still
>     interesting. This removes a large chunk of differences when comparing
>     perf script output for libunwind and libdw perf unwinding.
> 
> If not, then this could explain the issue you are seeing.

Hi Millian, can I take this as an Acked-by or Tested-by?

- Arnaldo
