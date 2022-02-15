Return-Path: <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8AABBC433F5
	for <linuxppc-dev@archiver.kernel.org>; Tue, 15 Feb 2022 05:30:45 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4JyV6q5HRgz3clN
	for <linuxppc-dev@archiver.kernel.org>; Tue, 15 Feb 2022 16:30:43 +1100 (AEDT)
Received: from gandalf.ozlabs.org (mail.ozlabs.org
 [IPv6:2404:9400:2221:ea00::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4JyV5z5Rrhz30Mf
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 15 Feb 2022 16:29:59 +1100 (AEDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4JyV5z0rVRz4xsm;
 Tue, 15 Feb 2022 16:29:59 +1100 (AEDT)
From: Michael Ellerman <patch-notifications@ellerman.id.au>
To: Maxim Kiselev <bigunclemax@gmail.com>
In-Reply-To: <20211230151123.1258321-1-bigunclemax@gmail.com>
References: <20211230151123.1258321-1-bigunclemax@gmail.com>
Subject: Re: [PATCH] powerpc: dts: t104xrdb: fix phy type for FMAN 4/5
Message-Id: <164490279029.270256.18216882664058931903.b4-ty@ellerman.id.au>
Date: Tue, 15 Feb 2022 16:26:30 +1100
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
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, fido_max@inbox.ru,
 Rob Herring <robh+dt@kernel.org>, Paul Mackerras <paulus@samba.org>,
 linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Thu, 30 Dec 2021 18:11:21 +0300, Maxim Kiselev wrote:
> T1040RDB has two RTL8211E-VB phys which requires setting
> of internal delays for correct work.
> 
> Changing the phy-connection-type property to `rgmii-id`
> will fix this issue.
> 
> 
> [...]

Applied to powerpc/next.

[1/1] powerpc: dts: t104xrdb: fix phy type for FMAN 4/5
      https://git.kernel.org/powerpc/c/17846485dff91acce1ad47b508b633dffc32e838

cheers
