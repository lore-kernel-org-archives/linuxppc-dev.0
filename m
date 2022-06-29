Return-Path: <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0EB47C433EF
	for <linuxppc-dev@archiver.kernel.org>; Wed, 29 Jun 2022 12:18:29 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4LY0qR4pPCz3fJ7
	for <linuxppc-dev@archiver.kernel.org>; Wed, 29 Jun 2022 22:18:27 +1000 (AEST)
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4LY0n62B2dz3dqF
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 29 Jun 2022 22:16:26 +1000 (AEST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4LY0n61XH8z4xZg;
	Wed, 29 Jun 2022 22:16:26 +1000 (AEST)
From: Michael Ellerman <patch-notifications@ellerman.id.au>
To: Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@lists.ozlabs.org
In-Reply-To: <20220619233103.2666171-1-mpe@ellerman.id.au>
References: <20220619233103.2666171-1-mpe@ellerman.id.au>
Subject: Re: [PATCH] selftests/powerpc: Skip energy_scale_info test on older firmware
Message-Id: <165650492809.3004956.3891863380142289739.b4-ty@ellerman.id.au>
Date: Wed, 29 Jun 2022 22:15:28 +1000
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
Cc: psampat@linux.ibm.com
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev" <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Mon, 20 Jun 2022 09:31:03 +1000, Michael Ellerman wrote:
> Older machines don't have the firmware feature that enables the code
> this test is testing. Skip the test if the sysfs directory doesn't
> exist. Also use the FAIL_IF() macro to provide more verbose error
> reporting if an error is encountered.
> 
> 

Applied to powerpc/next.

[1/1] selftests/powerpc: Skip energy_scale_info test on older firmware
      https://git.kernel.org/powerpc/c/4228a996b072d36f3baafb4afdc2d2d66d2cbadf

cheers
