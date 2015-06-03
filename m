Return-Path: <jolsa@redhat.com>
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id C41D61A0063
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  4 Jun 2015 00:25:28 +1000 (AEST)
Date: Wed, 3 Jun 2015 16:25:20 +0200
From: Jiri Olsa <jolsa@redhat.com>
To: Andi Kleen <ak@linux.intel.com>
Cc: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>, mingo@redhat.com,
 Michael Ellerman <mpe@ellerman.id.au>,
 Arnaldo Carvalho de Melo <acme@kernel.org>, namhyung@kernel.org,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v13 12/14] perf, tools: Add support for event list topics
Message-ID: <20150603142520.GA30890@krava>
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

On Wed, Jun 03, 2015 at 05:57:33AM -0700, Andi Kleen wrote:
> > please split at least the jevents Topic parsing from the rest
> > idelay also the alias update and the display change
> 
> What's the point of all these splits? It's already one logical unit,
> not too large, and is bisectable.

splitting the patch in logical pieces helps review and distro
backporting 

You changed the parsing tool and perf alias code that uses
the new output. IMO it's separate enough to be placed into
separate patches.

I believe the review would have been easier for me if those changes
were separate, also easing my job when backporting this change later
into the distro

jirka
