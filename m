Return-Path: <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 202C4C433FE
	for <linuxppc-dev@archiver.kernel.org>; Tue, 24 May 2022 11:15:48 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4L6s7k5G0Wz3cCN
	for <linuxppc-dev@archiver.kernel.org>; Tue, 24 May 2022 21:15:46 +1000 (AEST)
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4L6s7N2ZQDz2yh9
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 24 May 2022 21:15:28 +1000 (AEST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4L6s7L1HTPz4xYX;
 Tue, 24 May 2022 21:15:26 +1000 (AEST)
From: Michael Ellerman <patch-notifications@ellerman.id.au>
To: Reza Arbab <arbab@linux.ibm.com>, linuxppc-dev@lists.ozlabs.org
In-Reply-To: <20220503170152.23412-1-arbab@linux.ibm.com>
References: <20220503170152.23412-1-arbab@linux.ibm.com>
Subject: Re: [PATCH] powerpc: Enable the DAWR on POWER9 DD2.3 and above
Message-Id: <165339059263.1718562.6276025985187883167.b4-ty@ellerman.id.au>
Date: Tue, 24 May 2022 21:09:52 +1000
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
Cc: Michael Neuling <mikey@neuling.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Tue, 3 May 2022 12:01:52 -0500, Reza Arbab wrote:
> The hardware bug in POWER9 preventing use of the DAWR was fixed in
> DD2.3. Set the CPU_FTR_DAWR feature bit on these newer systems to start
> using it again, and update the documentation accordingly.
> 
> The CPU features for DD2.3 are currently determined by "DD2.2 or later"
> logic. In adding DD2.3 as a discrete case for the first time here, I'm
> carrying the quirks of DD2.2 forward to keep all behavior outside of
> this DAWR change the same. This leaves the assessment and potential
> removal of those quirks on DD2.3 for later.
> 
> [...]

Applied to powerpc/next.

[1/1] powerpc: Enable the DAWR on POWER9 DD2.3 and above
      https://git.kernel.org/powerpc/c/26b78c81e84c5133b299fb11bf17ec1a3d2ad217

cheers
