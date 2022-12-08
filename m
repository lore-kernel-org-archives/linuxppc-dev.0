Return-Path: <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11A36C3A5A7
	for <linuxppc-dev@archiver.kernel.org>; Thu,  8 Dec 2022 13:02:19 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4NSZ7F5Lrkz3fg4
	for <linuxppc-dev@archiver.kernel.org>; Fri,  9 Dec 2022 00:02:17 +1100 (AEDT)
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4NSYs64zx8z3bh1
	for <linuxppc-dev@lists.ozlabs.org>; Thu,  8 Dec 2022 23:50:02 +1100 (AEDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4NSYs63Td2z4xDn;
	Thu,  8 Dec 2022 23:50:02 +1100 (AEDT)
From: Michael Ellerman <patch-notifications@ellerman.id.au>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>, Michael Ellerman <mpe@ellerman.id.au>, Paul Mackerras <paulus@samba.org>, Pali Rohár <pali@kernel.org>
In-Reply-To: <20220820123327.20551-1-pali@kernel.org>
References: <20220820123327.20551-1-pali@kernel.org>
Subject: Re: [PATCH] powerpc/fsl-pci: Choose PCI host bridge with alias pci0 as the primary
Message-Id: <167050317771.1457988.13400779927133880901.b4-ty@ellerman.id.au>
Date: Thu, 08 Dec 2022 23:39:37 +1100
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
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev" <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Sat, 20 Aug 2022 14:33:27 +0200, Pali Rohár wrote:
> If there's no PCI host bridge with ISA then check for PCI host bridge with
> alias "pci0" (first PCI host bridge) and if it exists then choose it as the
> primary PCI host bridge.
> 
> This makes choice of primary PCI host bridge more stable across boots and
> updates as the last fallback candidate for primary PCI host bridge (if
> there is no choice) is selected arbitrary.
> 
> [...]

Applied to powerpc/next.

[1/1] powerpc/fsl-pci: Choose PCI host bridge with alias pci0 as the primary
      https://git.kernel.org/powerpc/c/e082e99f6f87f5204b2531d5a3db7bbd929d23b1

cheers
