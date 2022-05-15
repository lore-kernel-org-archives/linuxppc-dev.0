Return-Path: <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2BC71C433EF
	for <linuxppc-dev@archiver.kernel.org>; Sun, 15 May 2022 10:16:58 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4L1JG04Y7Gz3cFN
	for <linuxppc-dev@archiver.kernel.org>; Sun, 15 May 2022 20:16:56 +1000 (AEST)
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4L1JCC0dKMz3bx3
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 15 May 2022 20:14:31 +1000 (AEST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4L1JCB6mk3z4xZ2;
 Sun, 15 May 2022 20:14:30 +1000 (AEST)
From: Michael Ellerman <patch-notifications@ellerman.id.au>
To: linuxppc-dev@lists.ozlabs.org, Hari Bathini <hbathini@linux.ibm.com>,
 mpe@ellerman.id.au
In-Reply-To: <20220404182137.59231-1-hbathini@linux.ibm.com>
References: <20220404182137.59231-1-hbathini@linux.ibm.com>
Subject: Re: [PATCH] powerpc/fadump: save CPU reg data in vmcore when PHYP
 terminates LPAR
Message-Id: <165260954039.1040779.8580824821320588810.b4-ty@ellerman.id.au>
Date: Sun, 15 May 2022 20:12:20 +1000
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
Cc: Mahesh J Salgaonkar <mahesh@linux.ibm.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Mon, 4 Apr 2022 23:51:37 +0530, Hari Bathini wrote:
> An LPAR can be terminated by the POWER Hypervisor (PHYP) for various
> reasons. If FADump was configured when PHYP terminates the LPAR,
> platform-assisted dump is initiated to save the kernel dump. But CPU
> register data would not be processed/saved in the vmcore in such case
> because CPU mask is set in crash_fadump() at the time of kernel crash
> and it remains unset in this case with LPAR being terminated by PHYP
> abruptly.
> 
> [...]

Applied to powerpc/next.

[1/1] powerpc/fadump: save CPU reg data in vmcore when PHYP terminates LPAR
      https://git.kernel.org/powerpc/c/6584cec0a2255ab407d047d1b135fa0aae88d6c6

cheers
