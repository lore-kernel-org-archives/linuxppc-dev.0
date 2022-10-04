Return-Path: <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2064BC433F5
	for <linuxppc-dev@archiver.kernel.org>; Tue,  4 Oct 2022 13:39:42 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Mhf2N4QhSz3bjh
	for <linuxppc-dev@archiver.kernel.org>; Wed,  5 Oct 2022 00:39:40 +1100 (AEDT)
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Mhf1K195Qz2xf6
	for <linuxppc-dev@lists.ozlabs.org>; Wed,  5 Oct 2022 00:38:45 +1100 (AEDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4Mhf1J4Vbbz4xGs;
	Wed,  5 Oct 2022 00:38:44 +1100 (AEDT)
From: Michael Ellerman <patch-notifications@ellerman.id.au>
To: jolsa@kernel.org, Athira Rajeev <atrajeev@linux.vnet.ibm.com>, acme@kernel.org, mpe@ellerman.id.au
In-Reply-To: <20220921145255.20972-1-atrajeev@linux.vnet.ibm.com>
References: <20220921145255.20972-1-atrajeev@linux.vnet.ibm.com>
Subject: Re: (subset) [PATCH V2 1/3] powerpc/perf: Fix branch_filter support for multiple filters in powerpc
Message-Id: <166488994565.779920.440863414238574866.b4-ty@ellerman.id.au>
Date: Wed, 05 Oct 2022 00:25:45 +1100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-BeenThere: linuxppc-dev@lists.ozlabs.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Cc: maddy@linux.vnet.ibm.com, rnsastry@linux.ibm.com, kjain@linux.ibm.com, linux-perf-users@vger.kernel.org, disgoel@linux.vnet.ibm.com, linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev" <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Wed, 21 Sep 2022 20:22:53 +0530, Athira Rajeev wrote:
> For PERF_SAMPLE_BRANCH_STACK sample type, different branch_sample_type
> ie branch filters are supported. The branch filters are requested via
> event attribute "branch_sample_type". Multiple branch filters can be
> passed in event attribute.
> 
> Example:
> perf record -b -o- -B --branch-filter any,ind_call true
> 
> [...]

Patch 3 applied to powerpc/next.

[3/3] tools/testing/selftests/powerpc: Update the bhrb filter sampling test to test for multiple branch filters
      https://git.kernel.org/powerpc/c/18213532de7156af689cb0511d2f95bcbe3c98a0

cheers
