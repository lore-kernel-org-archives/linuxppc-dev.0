Return-Path: <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C333C48BEB
	for <linuxppc-dev@archiver.kernel.org>; Wed, 21 Feb 2024 23:10:25 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4TgBnq4bfmz3vZh
	for <linuxppc-dev@archiver.kernel.org>; Thu, 22 Feb 2024 10:10:23 +1100 (AEDT)
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4TgBmp3Jrtz30NP
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 22 Feb 2024 10:09:30 +1100 (AEDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4TgBmk0GGVz4wyY;
	Thu, 22 Feb 2024 10:09:26 +1100 (AEDT)
From: Michael Ellerman <patch-notifications@ellerman.id.au>
To: Nicholas Piggin <npiggin@gmail.com>, Christophe Leroy <christophe.leroy@csgroup.eu>, "Aneesh Kumar K . V" <aneesh.kumar@kernel.org>, "Naveen N . Rao" <naveen.n.rao@linux.ibm.com>, linuxppc-dev@lists.ozlabs.org, Masahiro Yamada <masahiroy@kernel.org>
In-Reply-To: <20240216135817.2003106-1-masahiroy@kernel.org>
References: <20240216135817.2003106-1-masahiroy@kernel.org>
Subject: Re: [PATCH] powerpc: remove unused KCSAN_SANITIZE_early_64.o in Makefile
Message-Id: <170855692314.1938434.16998260392268778285.b4-ty@ellerman.id.au>
Date: Thu, 22 Feb 2024 10:08:43 +1100
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
Cc: linux-kernel@vger.kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev" <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Fri, 16 Feb 2024 22:58:17 +0900, Masahiro Yamada wrote:
> Commit 2fb857bc9f9e ("powerpc/kcsan: Add exclusions from instrumentation")
> added KCSAN_SANITIZE_early_64.o to arch/powerpc/kernel/Makefile, while
> it does not compile early_64.o.
> 
> 

Applied to powerpc/next.

[1/1] powerpc: remove unused KCSAN_SANITIZE_early_64.o in Makefile
      https://git.kernel.org/powerpc/c/97a5253d7c3076ba0dbba8bf30179e079c9c912b

cheers
