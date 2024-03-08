Return-Path: <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4B4CC54798
	for <linuxppc-dev@archiver.kernel.org>; Fri,  8 Mar 2024 01:31:07 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4TrTCG4T5Hz3vcH
	for <linuxppc-dev@archiver.kernel.org>; Fri,  8 Mar 2024 12:31:06 +1100 (AEDT)
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4TrT9z1nY3z3bsP
	for <linuxppc-dev@lists.ozlabs.org>; Fri,  8 Mar 2024 12:29:59 +1100 (AEDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4TrT9x1nd6z4wcl;
	Fri,  8 Mar 2024 12:29:57 +1100 (AEDT)
From: Michael Ellerman <patch-notifications@ellerman.id.au>
To: Nicholas Piggin <npiggin@gmail.com>, "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>, "Naveen N. Rao" <naveen.n.rao@linux.ibm.com>, Nathan Lynch <nathanl@linux.ibm.com>
In-Reply-To: <20240222-rtas-fix-ibm-reset-pe-dma-window-v1-1-7aaf235ac63c@linux.ibm.com>
References: <20240222-rtas-fix-ibm-reset-pe-dma-window-v1-1-7aaf235ac63c@linux.ibm.com>
Subject: Re: [PATCH] powerpc/rtas: use correct function name for resetting TCE tables
Message-Id: <170986134194.348034.1743218337061952862.b4-ty@ellerman.id.au>
Date: Fri, 08 Mar 2024 12:29:01 +1100
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
Cc: Gaurav Batra <gbatra@linux.ibm.com>, linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev" <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Thu, 22 Feb 2024 16:19:14 -0600, Nathan Lynch wrote:
> The PAPR spec spells the function name as
> 
>   "ibm,reset-pe-dma-windows"
> 
> but in practice firmware uses the singular form:
> 
>   "ibm,reset-pe-dma-window"
> 
> [...]

Applied to powerpc/fixes.

[1/1] powerpc/rtas: use correct function name for resetting TCE tables
      https://git.kernel.org/powerpc/c/fad87dbd48156ab940538f052f1820f4b6ed2819

cheers
