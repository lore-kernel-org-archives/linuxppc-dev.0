Return-Path: <acme@kernel.org>
Received: from mail.kernel.org (mail.kernel.org [198.145.29.136])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3skfRT61DLzDrXd
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 28 Sep 2016 23:57:57 +1000 (AEST)
Date: Wed, 28 Sep 2016 10:57:47 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
Cc: peterz@infradead.org, maddy@linux.vnet.ibm.com,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v21 06/19] perf, tools: Support alias descriptions
Message-ID: <20160928135747.GB7467@kernel.org>
References: <1473978296-20712-1-git-send-email-sukadev@linux.vnet.ibm.com>
 <1473978296-20712-7-git-send-email-sukadev@linux.vnet.ibm.com>
 <20160927174100.GO5588@kernel.org>
 <20160927181116.GA18012@us.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20160927181116.GA18012@us.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Em Tue, Sep 27, 2016 at 11:11:16AM -0700, Sukadev Bhattiprolu escreveu:
> Arnaldo Carvalho de Melo [acme@kernel.org] wrote:
> > Em Thu, Sep 15, 2016 at 03:24:43PM -0700, Sukadev Bhattiprolu escreveu:
> > > From: Andi Kleen <ak@linux.intel.com>
> > > Add support to print alias descriptions in perf list, which
> > > are taken from the generated event files.
> > > 
> > > The sorting code is changed to put the events with descriptions
> > > at the end. The descriptions are printed as possibly multiple word
> > > wrapped lines.
> > 
> > So, now I'm trying to reproduce the results below, but I couldn't find a
> > tarball with those .json files for me to use, can you provide me with
> > one?
> 
> The data files are in my github, in the json-code+data-v21 branch
> starting with 23bb101. They are individual commits rather than a
> tarball though.

Ok, I'll pick one for powerpc and another for x86_64 so that I can test
it and Jiri's x-compile support.

Refresh my mind, what is the plan on these files? Are we just going to
provide pointers to where to get them from vendors, ship it in the
kernel, auto-download them as part of the build process?

At least examples that allows to build and have a new 'perf test' entry
to check them automatically seems to be in order, no?

- Arnaldo
 
> 	>       https://github.com/sukadev/linux.git
> 	>
> 	>       Branch                  Description
> 	>       ------------------------------------------------------
> 	>       json-code-v21           Source Code only
> 	>       json-code+data-v21      Both code and data(for build/test/pull)
> 	> 
> 
> Sukadev
