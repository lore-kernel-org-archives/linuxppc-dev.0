Return-Path: <SRS0=o3RY=O7=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C54EFC43387
	for <linuxppc-dev@archiver.kernel.org>; Sat, 22 Dec 2018 10:21:58 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6AB68219FD
	for <linuxppc-dev@archiver.kernel.org>; Sat, 22 Dec 2018 10:21:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6AB68219FD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43MM440BgWzDqdR
	for <linuxppc-dev@archiver.kernel.org>; Sat, 22 Dec 2018 21:21:56 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43MLSg0qL3zDqTd
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 22 Dec 2018 20:54:43 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
Received: by ozlabs.org (Postfix, from userid 1034)
 id 43MLSf5Txrz9sPG; Sat, 22 Dec 2018 20:54:42 +1100 (AEDT)
X-powerpc-patch-notification: thanks
X-powerpc-patch-commit: 2fea82db113e4422ef5c8e6209908806e5fb6b63
X-Patchwork-Hint: ignore
In-Reply-To: <20181210215203.1936171-1-arnd@arndb.de>
To: Arnd Bergmann <arnd@arndb.de>, Russell Currey <ruscur@russell.cc>,
 Sam Bobroff <sbobroff@linux.ibm.com>, "Oliver O'Halloran" <oohall@gmail.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Subject: Re: powerpc: eeh_event: convert semaphore to completion
Message-Id: <43MLSf5Txrz9sPG@ozlabs.org>
Date: Sat, 22 Dec 2018 20:54:42 +1100 (AEDT)
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
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Mon, 2018-12-10 at 21:51:57 UTC, Arnd Bergmann wrote:
> For this use case, completions and semaphores are equivalent,
> but semaphores are an awkward interface that should generally
> be avoided, so use the completion instead.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/2fea82db113e4422ef5c8e62099088

cheers
