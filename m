Return-Path: <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 476C0C43334
	for <linuxppc-dev@archiver.kernel.org>; Thu,  9 Jun 2022 14:46:55 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4LJn3x5nctz3dvP
	for <linuxppc-dev@archiver.kernel.org>; Fri, 10 Jun 2022 00:46:53 +1000 (AEST)
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4LJn2H3Nlfz3bmQ
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 10 Jun 2022 00:45:27 +1000 (AEST)
Received: by gandalf.ozlabs.org (Postfix)
	id 4LJn2H3Ctgz4xZB; Fri, 10 Jun 2022 00:45:27 +1000 (AEST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4LJn2H2M9rz4xZ8;
	Fri, 10 Jun 2022 00:45:27 +1000 (AEST)
From: Michael Ellerman <patch-notifications@ellerman.id.au>
To: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@ozlabs.org>
In-Reply-To: <YoX1kZPnmUX4RZEK@cleo>
References: <YoX1kZPnmUX4RZEK@cleo>
Subject: Re: [PATCH] powerpc/kasan: Mark more real-mode code as not to be instrumented
Message-Id: <165478587050.589231.13160965405188733708.b4-ty@ellerman.id.au>
Date: Fri, 10 Jun 2022 00:44:30 +1000
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
Sender: "Linuxppc-dev" <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Thu, 19 May 2022 17:45:21 +1000, Paul Mackerras wrote:
> This marks more files and functions that can possibly be called in
> real mode as not to be instrumented by KASAN.  Most were found by
> inspection, except for get_pseries_errorlog() which was reported as
> causing a crash in testing.
> 
> 

Applied to powerpc/fixes.

[1/1] powerpc/kasan: Mark more real-mode code as not to be instrumented
      https://git.kernel.org/powerpc/c/743cdb7bd0f1cb32c03680c8b38257957db2e692

cheers
