Return-Path: <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5BF47C433EF
	for <linuxppc-dev@archiver.kernel.org>; Wed,  2 Mar 2022 12:48:13 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4K7v6g0W4jz3cMS
	for <linuxppc-dev@archiver.kernel.org>; Wed,  2 Mar 2022 23:48:11 +1100 (AEDT)
Received: from gandalf.ozlabs.org (mail.ozlabs.org
 [IPv6:2404:9400:2221:ea00::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4K7v504GXXz3bcm
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  2 Mar 2022 23:46:44 +1100 (AEDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4K7v4z1XYWz4xvG;
 Wed,  2 Mar 2022 23:46:43 +1100 (AEDT)
From: Michael Ellerman <patch-notifications@ellerman.id.au>
To: Paul Mackerras <paulus@samba.org>,
 Christophe Leroy <christophe.leroy@csgroup.eu>,
 Michael Ellerman <mpe@ellerman.id.au>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Nicholas Piggin <npiggin@gmail.com>
In-Reply-To: <1d862ce3eab3da6ca7ac47d4a78a18f154462511.1645806970.git.christophe.leroy@csgroup.eu>
References: <1d862ce3eab3da6ca7ac47d4a78a18f154462511.1645806970.git.christophe.leroy@csgroup.eu>
Subject: Re: [PATCH v1] powerpc/interrupt: Remove struct interrupt_state
Message-Id: <164622490826.2052779.1956163553651248861.b4-ty@ellerman.id.au>
Date: Wed, 02 Mar 2022 23:41:48 +1100
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
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Fri, 25 Feb 2022 17:36:22 +0100, Christophe Leroy wrote:
> Since commit ceff77efa4f8 ("powerpc/64e/interrupt: Use new interrupt
> context tracking scheme") struct interrupt_state has been empty and
> unused.
> 
> Remove it.
> 
> 
> [...]

Applied to powerpc/next.

[1/1] powerpc/interrupt: Remove struct interrupt_state
      https://git.kernel.org/powerpc/c/973e2e6462405d85d3e8bb02d516d5fe6d1193ed

cheers
