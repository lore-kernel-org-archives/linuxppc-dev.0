Return-Path: <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DDD74C00144
	for <linuxppc-dev@archiver.kernel.org>; Fri, 29 Jul 2022 13:15:18 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4LvSg93Qydz3fgr
	for <linuxppc-dev@archiver.kernel.org>; Fri, 29 Jul 2022 23:15:17 +1000 (AEST)
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4LvSZ43dPTz3c6x
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 29 Jul 2022 23:10:52 +1000 (AEST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4LvSZ42szVz4xG3;
	Fri, 29 Jul 2022 23:10:52 +1000 (AEST)
From: Michael Ellerman <patch-notifications@ellerman.id.au>
To: Hari Bathini <hbathini@linux.ibm.com>, Michael Ellerman <mpe@ellerman.id.au>
In-Reply-To: <20220630064942.192283-1-hbathini@linux.ibm.com>
References: <20220630064942.192283-1-hbathini@linux.ibm.com>
Subject: Re: [PATCH v2] powerpc/crash: save cpu register data in crash_smp_send_stop()
Message-Id: <165909977039.253830.14579897862506749945.b4-ty@ellerman.id.au>
Date: Fri, 29 Jul 2022 23:02:50 +1000
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
Cc: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, Nicholas Piggin <npiggin@gmail.com>, Sourabh Jain <sourabhjain@linux.ibm.com>, Mahesh J Salgaonkar <mahesh@linux.ibm.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev" <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Thu, 30 Jun 2022 12:19:42 +0530, Hari Bathini wrote:
> During kdump, two set of NMI IPIs are sent to secondary CPUs, if
> 'crash_kexec_post_notifiers' option is set. The first set of NMI IPIs
> to stop the CPUs and the other set to collect register data. Instead,
> capture register data for secondary CPUs while stopping them itself.
> Also, fallback to smp_send_stop() in case the function gets called
> without kdump configured.
> 
> [...]

Applied to powerpc/next.

[1/1] powerpc/crash: save cpu register data in crash_smp_send_stop()
      https://git.kernel.org/powerpc/c/c7255058b5430b5c42932383bd8887d591e7973a

cheers
