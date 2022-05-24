Return-Path: <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5528CC433F5
	for <linuxppc-dev@archiver.kernel.org>; Tue, 24 May 2022 11:26:25 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4L6sN00B6Jz3fJH
	for <linuxppc-dev@archiver.kernel.org>; Tue, 24 May 2022 21:26:24 +1000 (AEST)
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4L6s7x0fHnz3cgx
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 24 May 2022 21:15:57 +1000 (AEST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4L6s7x01MJz4yTN;
 Tue, 24 May 2022 21:15:56 +1000 (AEST)
From: Michael Ellerman <patch-notifications@ellerman.id.au>
To: Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Michael Ellerman <mpe@ellerman.id.au>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Rob Herring <robh+dt@kernel.org>, Paul Mackerras <paulus@samba.org>, Pali Rohár <pali@kernel.org>
In-Reply-To: <20220506203621.26314-1-pali@kernel.org>
References: <20220506203621.26314-1-pali@kernel.org>
Subject: Re: [PATCH] powerpc/85xx: P2020: Add fsl,mpc8548-pmc node
Message-Id: <165339056016.1718562.7051892610899050151.b4-ty@ellerman.id.au>
Date: Tue, 24 May 2022 21:09:20 +1000
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
Cc: devicetree@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Fri, 6 May 2022 22:36:21 +0200, Pali Rohár wrote:
> P2020 also contains Power Management Controller and their registers at
> offset 0xe0070 compatible with mpc8548. So add PMC node into DTS include
> file fsl/p2020si-post.dtsi
> 
> 

Applied to powerpc/next.

[1/1] powerpc/85xx: P2020: Add fsl,mpc8548-pmc node
      https://git.kernel.org/powerpc/c/294299b3d39e8b4ae10c12ef1ed71405ef7b1e43

cheers
