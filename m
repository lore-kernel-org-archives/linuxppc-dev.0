Return-Path: <SRS0=jSa2=PV=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FF39C433F5
	for <linuxppc-dev@archiver.kernel.org>; Tue,  2 Nov 2021 11:51:41 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 32D5760F56
	for <linuxppc-dev@archiver.kernel.org>; Tue,  2 Nov 2021 11:51:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 32D5760F56
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Hk7Xq6QN5z3glS
	for <linuxppc-dev@archiver.kernel.org>; Tue,  2 Nov 2021 22:51:39 +1100 (AEDT)
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org
 [IPv6:2404:9400:2:0:216:3eff:fee2:21ea])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4Hk7G65lVpz3c6W
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  2 Nov 2021 22:38:54 +1100 (AEDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4Hk7G64xjtz4xdm;
 Tue,  2 Nov 2021 22:38:54 +1100 (AEDT)
From: Michael Ellerman <patch-notifications@ellerman.id.au>
To: Russell Currey <ruscur@russell.cc>, linuxppc-dev@lists.ozlabs.org
In-Reply-To: <20211025102436.19177-1-ruscur@russell.cc>
References: <20211025102436.19177-1-ruscur@russell.cc>
Subject: Re: [PATCH] selftests/powerpc: Use date instead of EPOCHSECONDS in
 mitigation-patching.sh
Message-Id: <163584792057.1845480.15822844076288003416.b4-ty@ellerman.id.au>
Date: Tue, 02 Nov 2021 21:12:00 +1100
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
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Mon, 25 Oct 2021 20:24:36 +1000, Russell Currey wrote:
> The EPOCHSECONDS environment variable was added in bash 5.0 (released
> 2019).  Some distributions of the "stable" and "long-term" variety ship
> older versions of bash than this, so swap to using the date command
> instead.
> 
> "%s" was added to coreutils `date` in 1993 so we should be good, but who
> knows, it is a GNU extension and not part of the POSIX spec for `date`.
> 
> [...]

Applied to powerpc/next.

[1/1] selftests/powerpc: Use date instead of EPOCHSECONDS in mitigation-patching.sh
      https://git.kernel.org/powerpc/c/cb662608e546d755e3e1b51b30a269459323bf24

cheers
