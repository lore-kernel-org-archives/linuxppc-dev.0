Return-Path: <SRS0=fdF7=ZG=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D34CC432C3
	for <linuxppc-dev@archiver.kernel.org>; Thu, 14 Nov 2019 09:41:01 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2594A20709
	for <linuxppc-dev@archiver.kernel.org>; Thu, 14 Nov 2019 09:41:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2594A20709
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 47DGgv3VCkzF7Yk
	for <linuxppc-dev@archiver.kernel.org>; Thu, 14 Nov 2019 20:40:59 +1100 (AEDT)
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 47DFxm2Dh2zF5KG
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 14 Nov 2019 20:07:56 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
Received: by ozlabs.org (Postfix, from userid 1034)
 id 47DFxj5f70z9sRm; Thu, 14 Nov 2019 20:07:53 +1100 (AEDT)
X-powerpc-patch-notification: thanks
X-powerpc-patch-commit: b811be615cb78c90fca42bbd5b958427d03ba7e0
In-Reply-To: <20191017093204.7511-2-ravi.bangoria@linux.ibm.com>
To: Ravi Bangoria <ravi.bangoria@linux.ibm.com>, christophe.leroy@c-s.fr,
 mikey@neuling.org
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Subject: Re: [PATCH v6 1/7] Powerpc/Watchpoint: Introduce macros for
 watchpoint length
Message-Id: <47DFxj5f70z9sRm@ozlabs.org>
Date: Thu, 14 Nov 2019 20:07:53 +1100 (AEDT)
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
Cc: Ravi Bangoria <ravi.bangoria@linux.ibm.com>, linux-kernel@vger.kernel.org,
 npiggin@gmail.com, paulus@samba.org, naveen.n.rao@linux.vnet.ibm.com,
 linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Thu, 2019-10-17 at 09:31:58 UTC, Ravi Bangoria wrote:
> We are hadrcoding length everywhere in the watchpoint code.
> Introduce macros for the length and use them.
> 
> Signed-off-by: Ravi Bangoria <ravi.bangoria@linux.ibm.com>

Series applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/b811be615cb78c90fca42bbd5b958427d03ba7e0

cheers
