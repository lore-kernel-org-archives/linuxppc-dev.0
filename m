Return-Path: <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28A95C433F5
	for <linuxppc-dev@archiver.kernel.org>; Tue,  4 Oct 2022 14:04:02 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4MhfZS53Tmz3g6D
	for <linuxppc-dev@archiver.kernel.org>; Wed,  5 Oct 2022 01:04:00 +1100 (AEDT)
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Mhf1x3jX6z3c7B
	for <linuxppc-dev@lists.ozlabs.org>; Wed,  5 Oct 2022 00:39:17 +1100 (AEDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4Mhf1x2VKKz4xHv;
	Wed,  5 Oct 2022 00:39:17 +1100 (AEDT)
From: Michael Ellerman <patch-notifications@ellerman.id.au>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, Pali Rohár <pali@kernel.org>, Nick Child <nick.child@ibm.com>, Michael Ellerman <mpe@ellerman.id.au>
In-Reply-To: <20220822231501.16827-1-pali@kernel.org>
References: <20220819211254.22192-1-pali@kernel.org> <20220822231501.16827-1-pali@kernel.org>
Subject: Re: [PATCH v2] powerpc: Add support for early debugging via Serial 16550 console
Message-Id: <166488992434.779920.6350894757814995765.b4-ty@ellerman.id.au>
Date: Wed, 05 Oct 2022 00:25:24 +1100
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

On Tue, 23 Aug 2022 01:15:01 +0200, Pali Rohár wrote:
> Currently powerpc early debugging contains lot of platform specific
> options, but does not support standard UART / serial 16550 console.
> 
> Later legacy_serial.c code supports registering UART as early debug console
> from device tree but it is not early during booting, but rather later after
> machine description code finishes.
> 
> [...]

Applied to powerpc/next.

[1/1] powerpc: Add support for early debugging via Serial 16550 console
      https://git.kernel.org/powerpc/c/b19448fe846baad689ff51a991ebfc74b4b5e0a8

cheers
