Return-Path: <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 282C6C00144
	for <linuxppc-dev@archiver.kernel.org>; Fri, 29 Jul 2022 13:15:41 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4LvSgb4nnqz3fm0
	for <linuxppc-dev@archiver.kernel.org>; Fri, 29 Jul 2022 23:15:39 +1000 (AEST)
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4LvSZ52rdhz3c8h
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 29 Jul 2022 23:10:53 +1000 (AEST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4LvSZ46gSTz4x1b;
	Fri, 29 Jul 2022 23:10:52 +1000 (AEST)
From: Michael Ellerman <patch-notifications@ellerman.id.au>
To: Joel Stanley <joel@jms.id.au>, Madhavan Srinivasan <maddy@linux.ibm.com>, linuxppc-dev@lists.ozlabs.org
In-Reply-To: <20220610044006.2095806-1-joel@jms.id.au>
References: <20220610044006.2095806-1-joel@jms.id.au>
Subject: Re: [PATCH v2] powerpc/perf: Give generic PMU a nice name
Message-Id: <165909971193.253830.9514419745791581071.b4-ty@ellerman.id.au>
Date: Fri, 29 Jul 2022 23:01:51 +1000
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
Cc: Athira Rajeev <atrajeev@linux.ibm.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev" <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Fri, 10 Jun 2022 14:10:06 +0930, Joel Stanley wrote:
> When booting on a machine that uses the compat pmu driver we see this:
> 
>  [    0.071192] GENERIC_COMPAT performance monitor hardware support registered
> 
> Which is a bit shouty. Give it a nicer name.
> 
> 
> [...]

Applied to powerpc/next.

[1/1] powerpc/perf: Give generic PMU a nice name
      https://git.kernel.org/powerpc/c/78988b273d592ce74c8aecdd5d748906c38a9e9d

cheers
