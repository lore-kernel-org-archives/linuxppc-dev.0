Return-Path: <acme@kernel.org>
Received: from mail.kernel.org (mail.kernel.org [198.145.29.136])
 by lists.ozlabs.org (Postfix) with ESMTP id 5B44C1A015D
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  3 Jun 2015 23:26:55 +1000 (AEST)
Date: Wed, 3 Jun 2015 10:26:49 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Andi Kleen <ak@linux.intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>,
 Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>, mingo@redhat.com,
 Michael Ellerman <mpe@ellerman.id.au>, namhyung@kernel.org,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v13 12/14] perf, tools: Add support for event list topics
Message-ID: <20150603132649.GV624@kernel.org>
References: <1433265135-20426-1-git-send-email-sukadev@linux.vnet.ibm.com>
 <1433265135-20426-13-git-send-email-sukadev@linux.vnet.ibm.com>
 <20150602191641.GA3978@us.ibm.com>
 <20150603103229.GK1828@krava.redhat.com>
 <20150603125733.GS1187@tassilo.jf.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20150603125733.GS1187@tassilo.jf.intel.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Em Wed, Jun 03, 2015 at 05:57:33AM -0700, Andi Kleen escreveu:
> > please split at least the jevents Topic parsing from the rest
> > idelay also the alias update and the display change
> 
> What's the point of all these splits? It's already one logical unit,
> not too large, and is bisectable.

Eases review, improves bisectability, and its a reasonable request from
a reviewer/maintainer that has to look at an evergrowing number of patch
flows.

- Arnaldo
