Return-Path: <acme@kernel.org>
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xN2281N0szDr2y
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  3 Aug 2017 04:36:00 +1000 (AEST)
Date: Wed, 2 Aug 2017 15:35:54 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
Cc: Jiri Olsa <jolsa@redhat.com>, Michael Ellerman <mpe@ellerman.id.au>,
 Anton Blanchard <anton@au1.ibm.com>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
Subject: Re: [GIT PULL] Please pull JSON files for Power9 PMU events
Message-ID: <20170802183554.GJ12201@kernel.org>
References: <20170802174617.GA32545@us.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170802174617.GA32545@us.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Em Wed, Aug 02, 2017 at 10:46:17AM -0700, Sukadev Bhattiprolu escreveu:
> Hi Arnaldo,
> 
> Please pull some updates/cleanups to the POWER9 PMU events.
> 
> The following changes since commit 81e3d8b2af2e7417f1d5164aab5c1a75955e8a5d:
> 
>   perf trace beautify ioctl: Beautify perf ioctl's 'cmd' arg (2017-08-01 13:33:50 -0300)

Thanks, applied.

- Arnaldo
