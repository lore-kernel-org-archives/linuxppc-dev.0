Return-Path: <SRS0=jSa2=PV=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7BFBC433F5
	for <linuxppc-dev@archiver.kernel.org>; Tue,  2 Nov 2021 11:46:19 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2252E60EE3
	for <linuxppc-dev@archiver.kernel.org>; Tue,  2 Nov 2021 11:46:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 2252E60EE3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Hk7Qd5xz7z3fns
	for <linuxppc-dev@archiver.kernel.org>; Tue,  2 Nov 2021 22:46:17 +1100 (AEDT)
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org
 [IPv6:2404:9400:2:0:216:3eff:fee2:21ea])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4Hk7Fv30QPz2yP7
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  2 Nov 2021 22:38:43 +1100 (AEDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4Hk7Fv0N5hz4xdS;
 Tue,  2 Nov 2021 22:38:43 +1100 (AEDT)
From: Michael Ellerman <patch-notifications@ellerman.id.au>
To: Vasant Hegde <hegdevasant@linux.vnet.ibm.com>,
 linuxppc-dev@lists.ozlabs.org
In-Reply-To: <20211028165716.41300-1-hegdevasant@linux.vnet.ibm.com>
References: <20211028165716.41300-1-hegdevasant@linux.vnet.ibm.com>
Subject: Re: [PATCH v2] powerpc/powernv/prd: Unregister OPAL_MSG_PRD2 notifier
 during module unload
Message-Id: <163584792948.1845480.17297151596830428887.b4-ty@ellerman.id.au>
Date: Tue, 02 Nov 2021 21:12:09 +1100
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
Cc: dja@axtens.net
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Thu, 28 Oct 2021 22:27:16 +0530, Vasant Hegde wrote:
> Commit 587164cd, introduced new opal message type (OPAL_MSG_PRD2) and added
> opal notifier. But I missed to unregister the notifier during module unload
> path. This results in below call trace if you try to unload and load
> opal_prd module.
> 
> Also add new notifier_block for OPAL_MSG_PRD2 message.
> 
> [...]

Applied to powerpc/next.

[1/1] powerpc/powernv/prd: Unregister OPAL_MSG_PRD2 notifier during module unload
      https://git.kernel.org/powerpc/c/52862ab33c5d97490f3fa345d6529829e6d6637b

cheers
