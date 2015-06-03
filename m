Return-Path: <ak@linux.intel.com>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 by lists.ozlabs.org (Postfix) with ESMTP id 3D76B1A004D
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  3 Jun 2015 22:57:50 +1000 (AEST)
Date: Wed, 3 Jun 2015 05:57:33 -0700
From: Andi Kleen <ak@linux.intel.com>
To: Jiri Olsa <jolsa@redhat.com>
Cc: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>, mingo@redhat.com,
 Michael Ellerman <mpe@ellerman.id.au>,
 Arnaldo Carvalho de Melo <acme@kernel.org>, namhyung@kernel.org,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v13 12/14] perf, tools: Add support for event list topics
Message-ID: <20150603125733.GS1187@tassilo.jf.intel.com>
References: <1433265135-20426-1-git-send-email-sukadev@linux.vnet.ibm.com>
 <1433265135-20426-13-git-send-email-sukadev@linux.vnet.ibm.com>
 <20150602191641.GA3978@us.ibm.com>
 <20150603103229.GK1828@krava.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20150603103229.GK1828@krava.redhat.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

> please split at least the jevents Topic parsing from the rest
> idelay also the alias update and the display change

What's the point of all these splits? It's already one logical unit,
not too large, and is bisectable.

-andi

-- 
ak@linux.intel.com -- Speaking for myself only
