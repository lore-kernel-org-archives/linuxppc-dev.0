Return-Path: <SRS0=o3RY=O7=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B347C433F5
	for <linuxppc-dev@archiver.kernel.org>; Mon, 11 Oct 2021 12:11:47 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9642260E53
	for <linuxppc-dev@archiver.kernel.org>; Mon, 11 Oct 2021 12:11:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 9642260E53
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4HSd286QJjz3dpN
	for <linuxppc-dev@archiver.kernel.org>; Mon, 11 Oct 2021 23:11:44 +1100 (AEDT)
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4HScxn6D9dz2ywR
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 11 Oct 2021 23:07:57 +1100 (AEDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4HScxn4DC6z4xqW;
 Mon, 11 Oct 2021 23:07:57 +1100 (AEDT)
From: Michael Ellerman <patch-notifications@ellerman.id.au>
To: linuxppc-dev@lists.ozlabs.org, Nathan Lynch <nathanl@linux.ibm.com>
In-Reply-To: <20210927201933.76786-1-nathanl@linux.ibm.com>
References: <20210927201933.76786-1-nathanl@linux.ibm.com>
Subject: Re: [PATCH v2 0/4] CPU DLPAR/hotplug for v5.16
Message-Id: <163395401463.4094789.3310555121378614252.b4-ty@ellerman.id.au>
Date: Mon, 11 Oct 2021 23:06:54 +1100
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
Cc: aneesh.kumar@linux.ibm.com, ldufour@linux.ibm.com, danielhb413@gmail.com,
 tyreld@linux.ibm.com
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Mon, 27 Sep 2021 15:19:29 -0500, Nathan Lynch wrote:
> Fixes for some vintage bugs in handling cache node addition and removal, a
> miscellaneous BUG->WARN conversion, and removal of the fragile "by count"
> CPU DLPAR code that probably has no users.
> 
> Changes since v1:
> * Remove set but unused local variable (0day)
> * Additional comment cleanup patch
> 
> [...]

Applied to powerpc/next.

[1/4] powerpc/pseries/cpuhp: cache node corrections
      https://git.kernel.org/powerpc/c/7edd5c9a8820bedb22870b34a809d45f2a86a35a
[2/4] powerpc/cpuhp: BUG -> WARN conversion in offline path
      https://git.kernel.org/powerpc/c/983f9101740641434cea4f2e172175ff4b0276ad
[3/4] powerpc/pseries/cpuhp: delete add/remove_by_count code
      https://git.kernel.org/powerpc/c/fa2a5dfe2ddd0e7c77e5f608e1fa374192e5be97
[4/4] powerpc/pseries/cpuhp: remove obsolete comment from pseries_cpu_die
      https://git.kernel.org/powerpc/c/f9473a65719e59c45f1638cc04db7c80de8fcc1a

cheers
