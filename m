Return-Path: <SRS0=jSa2=PV=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1999C433FE
	for <linuxppc-dev@archiver.kernel.org>; Tue,  2 Nov 2021 11:39:07 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 43F1860F5A
	for <linuxppc-dev@archiver.kernel.org>; Tue,  2 Nov 2021 11:39:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 43F1860F5A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Hk7GK6KMbz3cHW
	for <linuxppc-dev@archiver.kernel.org>; Tue,  2 Nov 2021 22:39:05 +1100 (AEDT)
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org
 [IPv6:2404:9400:2:0:216:3eff:fee2:21ea])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4Hk7FX1Xkcz2xRp
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  2 Nov 2021 22:38:24 +1100 (AEDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4Hk7FS5YY5z4xcB;
 Tue,  2 Nov 2021 22:38:20 +1100 (AEDT)
From: Michael Ellerman <patch-notifications@ellerman.id.au>
To: Anatolij Gustschin <agust@denx.de>, linuxppc-dev@lists.ozlabs.org
In-Reply-To: <20211013220532.24759-1-agust@denx.de>
References: <20211013220532.24759-1-agust@denx.de>
Subject: Re: [PATCH 0/4] Update mpc5200 dts files to fix warnings
Message-Id: <163584790458.1845480.6370187649421665314.b4-ty@ellerman.id.au>
Date: Tue, 02 Nov 2021 21:11:44 +1100
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
Cc: devicetree@vger.kernel.org, Stephen Rothwell <sfr@canb.auug.org.au>,
 linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
 Paul Mackerras <paulus@samba.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Thu, 14 Oct 2021 00:05:28 +0200, Anatolij Gustschin wrote:
> This series fixes localbus, memory and pci node build warnings.
> It was tested with current linux-next on digsy_mtc and tqm5200
> boards.
> 
> Anatolij Gustschin (4):
>   powerpc/5200: dts: add missing pci ranges
>   powerpc/5200: dts: fix pci ranges warnings
>   powerpc/5200: dts: fix memory node unit name
>   powerpc/5200: dts: fix localbus node warnings
> 
> [...]

Patches 1-3 applied to powerpc/next.

[1/4] powerpc/5200: dts: add missing pci ranges
      https://git.kernel.org/powerpc/c/e9efabc6e4c31517394be13c2f0c5abadd33f328
[2/4] powerpc/5200: dts: fix pci ranges warnings
      https://git.kernel.org/powerpc/c/7855b6c66dc458e2f5abfb2b50f527ea4101df77
[3/4] powerpc/5200: dts: fix memory node unit name
      https://git.kernel.org/powerpc/c/aed2886a5e9ffc8269a4220bff1e9e030d3d2eb1

cheers
