Return-Path: <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 623D1C433EF
	for <linuxppc-dev@archiver.kernel.org>; Tue, 21 Dec 2021 12:16:13 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4JJFmW5Dt9z3c74
	for <linuxppc-dev@archiver.kernel.org>; Tue, 21 Dec 2021 23:16:11 +1100 (AEDT)
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4JJFlb0MJlz2xXf
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 21 Dec 2021 23:15:23 +1100 (AEDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4JJFlY2J3Xz4xn0;
 Tue, 21 Dec 2021 23:15:21 +1100 (AEDT)
From: Michael Ellerman <patch-notifications@ellerman.id.au>
To: linuxppc-dev@lists.ozlabs.org, Sachin Sant <sachinp@linux.vnet.ibm.com>
In-Reply-To: <163941374362.36967.18016981579099073379.sendpatchset@1.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.ip6.arpa>
References: <163941374362.36967.18016981579099073379.sendpatchset@1.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.ip6.arpa>
Subject: Re: [PATCH]selftests/powerpc: skip tests for unavailable mitigations.
Message-Id: <164008885692.2078648.5834426444949840972.b4-ty@ellerman.id.au>
Date: Tue, 21 Dec 2021 23:14:16 +1100
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
Cc: Nageswara R Sastry <rnsastry@linux.ibm.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Mon, 13 Dec 2021 22:12:23 +0530, Sachin Sant wrote:
> Mitigation patching test iterates over a set of mitigations irrespective
> of whether a certain mitigation is supported/available in the kernel.
> This causes following messages on a kernel where some mitigations
> are unavailable:
> 
>   Spawned threads enabling/disabling mitigations ...
>   cat: entry_flush: No such file or directory
>   cat: uaccess_flush: No such file or directory
>   Waiting for timeout ...
>   OK
> 
> [...]

Applied to powerpc/next.

[1/1] selftests/powerpc: skip tests for unavailable mitigations.
      https://git.kernel.org/powerpc/c/18678591846d668649fbd4f87b4a4c470818d386

cheers
