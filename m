Return-Path: <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64D42EE4993
	for <linuxppc-dev@archiver.kernel.org>; Wed, 23 Aug 2023 12:21:05 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4RW50c0gP9z3hlB
	for <linuxppc-dev@archiver.kernel.org>; Wed, 23 Aug 2023 22:21:04 +1000 (AEST)
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4RW4dp2K7vz3dGn
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 23 Aug 2023 22:04:46 +1000 (AEST)
Received: by gandalf.ozlabs.org (Postfix)
	id 4RW4dp1swwz4x2J; Wed, 23 Aug 2023 22:04:46 +1000 (AEST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4RW4dn5rTRz4wxW;
	Wed, 23 Aug 2023 22:04:45 +1000 (AEST)
From: Michael Ellerman <patch-notifications@ellerman.id.au>
To: linuxppc-dev@ozlabs.org, Sourabh Jain <sourabhjain@linux.ibm.com>
In-Reply-To: <20230704050715.203581-1-sourabhjain@linux.ibm.com>
References: <20230704050715.203581-1-sourabhjain@linux.ibm.com>
Subject: Re: [PATCH v2] powerpc/fadump: reset dump area size if fadump memory reserve fails
Message-Id: <169279175571.797584.9439403902285613957.b4-ty@ellerman.id.au>
Date: Wed, 23 Aug 2023 21:55:55 +1000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
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
Cc: mahesh@linux.vnet.ibm.com, Mahesh Salgaonkar <mahesh@linux.ibm.com>, hbathini@linux.ibm.com
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev" <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Tue, 04 Jul 2023 10:37:15 +0530, Sourabh Jain wrote:
> In case fadump_reserve_mem() fails to reserve memory, the
> reserve_dump_area_size variable will retain the reserve area size. This
> will lead to /sys/kernel/fadump/mem_reserved node displaying an incorrect
> memory reserved by fadump.
> 
> To fix this problem, reserve dump area size variable is set to 0 if fadump
> failed to reserve memory.
> 
> [...]

Applied to powerpc/next.

[1/1] powerpc/fadump: reset dump area size if fadump memory reserve fails
      https://git.kernel.org/powerpc/c/d1eb75e0dfed80d2d85b664e28a39f65b290ab55

cheers
