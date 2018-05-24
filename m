Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40s5Hz70x6zF1Qn
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 24 May 2018 20:30:39 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Michael Neuling <mikey@neuling.org>
Cc: linuxppc-dev@lists.ozlabs.org, mikey@neuling.org
Subject: Re: [PATCH 2/2] selftests/powerpc: Add perf breakpoint test
In-Reply-To: <20180522061428.5142-2-mikey@neuling.org>
References: <20180522061428.5142-1-mikey@neuling.org>
 <20180522061428.5142-2-mikey@neuling.org>
Date: Thu, 24 May 2018 20:30:33 +1000
Message-ID: <87tvqx4a7q.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Michael Neuling <mikey@neuling.org> writes:

> This tests perf hardware breakpoints (ie PERF_TYPE_BREAKPOINT) on
> powerpc.

This doesn't work for me on a P8 guest:

  test: perf-hwbreak
  tags: git_version:bb5602e
  !! killing perf-hwbreak
  !! child died by signal 15
  failure: perf-hwbreak


That means the harness killed it after 2 minutes.

Sometimes it gets further:

  test: perf-hwbreak
  tags: git_version:v4.17-rc3-109-gbb20240fb508
  threads=16 loops=1048576 scalar test
  !! killing perf-hwbreak
  !! child died by signal 15
  failure: perf-hwbreak


Do we just need to bump the timeout up, or is something going wrong
here?

cheers
