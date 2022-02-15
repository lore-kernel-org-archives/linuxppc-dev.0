Return-Path: <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A97BC433EF
	for <linuxppc-dev@archiver.kernel.org>; Tue, 15 Feb 2022 05:37:29 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4JyVGb5czlz3g1V
	for <linuxppc-dev@archiver.kernel.org>; Tue, 15 Feb 2022 16:37:27 +1100 (AEDT)
Received: from gandalf.ozlabs.org (mail.ozlabs.org
 [IPv6:2404:9400:2221:ea00::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4JyV6N28R9z3cRf
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 15 Feb 2022 16:30:20 +1100 (AEDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4JyV6N1Ss1z4y3m;
 Tue, 15 Feb 2022 16:30:20 +1100 (AEDT)
From: Michael Ellerman <patch-notifications@ellerman.id.au>
To: rdunlap@infradead.org, paulus@samba.org, mpe@ellerman.id.au,
 benh@kernel.crashing.org, linuxppc-dev@lists.ozlabs.org,
 Bhaskar Chowdhury <unixbhaskar@gmail.com>, linux-kernel@vger.kernel.org
In-Reply-To: <20210320213932.22697-1-unixbhaskar@gmail.com>
References: <20210320213932.22697-1-unixbhaskar@gmail.com>
Subject: Re: [PATCH] powerpc: epapr: A typo fix
Message-Id: <164490279633.270256.14303800612164733087.b4-ty@ellerman.id.au>
Date: Tue, 15 Feb 2022 16:26:36 +1100
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
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Sun, 21 Mar 2021 03:09:32 +0530, Bhaskar Chowdhury wrote:
> s/parmeters/parameters/
> 
> 

Applied to powerpc/next.

[1/1] powerpc: epapr: A typo fix
      https://git.kernel.org/powerpc/c/a1c414093370ed50e5b952d96d4ae775c7a18420

cheers
