Return-Path: <SRS0=OEx3=NM=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBA95C0044C
	for <linuxppc-dev@archiver.kernel.org>; Thu,  1 Nov 2018 12:48:54 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 547A62081B
	for <linuxppc-dev@archiver.kernel.org>; Thu,  1 Nov 2018 12:48:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 547A62081B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42m4l73pLgzF3Nv
	for <linuxppc-dev@archiver.kernel.org>; Thu,  1 Nov 2018 23:48:51 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42m4hq3dzWzF3Ln
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  1 Nov 2018 23:46:51 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
Received: by ozlabs.org (Postfix, from userid 1034)
 id 42m4hq26nZzB4XN; Thu,  1 Nov 2018 23:46:50 +1100 (AEDT)
X-powerpc-patch-notification: thanks
X-powerpc-patch-commit: a0aebae07f211c05d64be886e56d352eea86350b
In-Reply-To: <20181022120926.12797-1-joel@jms.id.au>
To: Joel Stanley <joel@jms.id.au>, linuxppc-dev@lists.ozlabs.org
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Subject: Re: selftests: powerpc: Fix warning for security subdir
Message-Id: <42m4hq26nZzB4XN@ozlabs.org>
Date: Thu,  1 Nov 2018 23:46:50 +1100 (AEDT)
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

On Mon, 2018-10-22 at 12:09:26 UTC, Joel Stanley wrote:
> typing 'make' inside tools/testing/selftests/powerpc gave a build
> warning:
> 
> BUILD_TARGET=tools/testing/selftests/powerpc/security; mkdir -p $BUILD_TARGET; make OUTPUT=$BUILD_TARGET -k -C security all
> make[1]: Entering directory 'tools/testing/selftests/powerpc/security'
> ../../lib.mk:20: ../../../../scripts/subarch.include: No such file or directory
> make[1]: *** No rule to make target '../../../../scripts/subarch.include'.
> make[1]: Failed to remake makefile '../../../../scripts/subarch.include'.
> 
> The build is one level deeper than lib.mk thinks it is. Set top_srcdir
> to set things straight.
> 
> Note that the test program is still built.
> 
> Signed-off-by: Joel Stanley <joel@jms.id.au>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/a0aebae07f211c05d64be886e56d35

cheers
