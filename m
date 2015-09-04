Return-Path: <acme@kernel.org>
Received: from mail.kernel.org (mail.kernel.org [198.145.29.136])
 by lists.ozlabs.org (Postfix) with ESMTP id 8961C1A1E32
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  5 Sep 2015 06:51:51 +1000 (AEST)
Date: Fri, 4 Sep 2015 17:51:45 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: Hemant Kumar <hemant@linux.vnet.ibm.com>, maddy@linux.vnet.ibm.com,
 srikar@linux.vnet.ibm.com, linux-kernel@vger.kernel.org,
 warrier@linux.vnet.ibm.com, paulus@samba.org,
 scottwood@freescale.com, sukadev@linux.vnet.ibm.com,
 linuxppc-dev@lists.ozlabs.org, mingo@kernel.org
Subject: Re: [PATCH v6 1/2] perf,kvm/powerpc: Add kvm_perf.h for powerpc
Message-ID: <20150904205145.GB3475@kernel.org>
References: <1441003681-10259-1-git-send-email-hemant@linux.vnet.ibm.com>
 <20150831201300.GG4423@kernel.org>
 <55E54A4F.6090205@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <55E54A4F.6090205@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Em Tue, Sep 01, 2015 at 12:18:47PM +0530, Hemant Kumar escreveu:
> >Should I try to process the 5 together, applying thest two first?
 
> Yes, this patchset needs to be applied before applying the other patchset,
> since there is a direct dependency on these two for the tooling part to
> work.
 
> >I see there are no acks from powerpc arch maintainers, how should we
> >proceed here? If there are no problems with the arch bits, and if it is
> >just to enable the tooling part, again, should I process the 5 as just
> >one series?
 
> The reason to split the earlier patchset into two was to separate the
> tooling/perf/ and arch/powerpc/ side patches, as asked by Michael..
 
> Here is the link to that discussion :
> http://www.mail-archive.com/linuxppc-dev@lists.ozlabs.org/msg86916.html
 
> If Michael is ok with the patches, you can process all the 5 patches
> together. Michael?

Michael?

- Arnaldo
