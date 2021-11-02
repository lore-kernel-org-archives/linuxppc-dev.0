Return-Path: <SRS0=jSa2=PV=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AA30C433EF
	for <linuxppc-dev@archiver.kernel.org>; Tue,  2 Nov 2021 11:44:49 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 33C7160EE3
	for <linuxppc-dev@archiver.kernel.org>; Tue,  2 Nov 2021 11:44:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 33C7160EE3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Hk7Nv6mwjz3fVw
	for <linuxppc-dev@archiver.kernel.org>; Tue,  2 Nov 2021 22:44:47 +1100 (AEDT)
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org
 [IPv6:2404:9400:2:0:216:3eff:fee2:21ea])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4Hk7Fp1PXgz2yJM
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  2 Nov 2021 22:38:38 +1100 (AEDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4Hk7Fn3n7xz4xdK;
 Tue,  2 Nov 2021 22:38:37 +1100 (AEDT)
From: Michael Ellerman <patch-notifications@ellerman.id.au>
To: Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 Christophe Leroy <christophe.leroy@csgroup.eu>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>
In-Reply-To: <a9ff3bc98035f63b122c051f02dc47c7aed10430.1635256089.git.christophe.leroy@csgroup.eu>
References: <a9ff3bc98035f63b122c051f02dc47c7aed10430.1635256089.git.christophe.leroy@csgroup.eu>
Subject: Re: [PATCH v3] powerpc/boot: Set LC_ALL=C in wrapper script
Message-Id: <163584791652.1845480.7970376759421988538.b4-ty@ellerman.id.au>
Date: Tue, 02 Nov 2021 21:11:56 +1100
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

On Tue, 26 Oct 2021 15:48:29 +0200, Christophe Leroy wrote:
> While trying to build a simple Image for ACADIA platform, I got the
> following error:
> 
> 	  WRAP    arch/powerpc/boot/simpleImage.acadia
> 	INFO: Uncompressed kernel (size 0x6ae7d0) overlaps the address of the wrapper(0x400000)
> 	INFO: Fixing the link_address of wrapper to (0x700000)
> 	powerpc64-linux-gnu-ld : mode d'émulation non reconnu : -T
> 	Émulations prises en charge : elf64ppc elf32ppc elf32ppclinux elf32ppcsim elf64lppc elf32lppc elf32lppclinux elf32lppcsim
> 	make[1]: *** [arch/powerpc/boot/Makefile:424 : arch/powerpc/boot/simpleImage.acadia] Erreur 1
> 	make: *** [arch/powerpc/Makefile:285 : simpleImage.acadia] Erreur 2
> 
> [...]

Applied to powerpc/next.

[1/1] powerpc/boot: Set LC_ALL=C in wrapper script
      https://git.kernel.org/powerpc/c/b949d009dd52ecdced248889cf11297677f9e8a6

cheers
