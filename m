Return-Path: <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F561C4321E
	for <linuxppc-dev@archiver.kernel.org>; Wed, 30 Nov 2022 09:35:22 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4NMYw86LGvz3fZt
	for <linuxppc-dev@archiver.kernel.org>; Wed, 30 Nov 2022 20:35:20 +1100 (AEDT)
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4NMYqj4Gt0z3bZJ
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 30 Nov 2022 20:31:29 +1100 (AEDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4NMYqj38mfz4xQr;
	Wed, 30 Nov 2022 20:31:29 +1100 (AEDT)
From: Michael Ellerman <patch-notifications@ellerman.id.au>
To: Nicholas Piggin <npiggin@gmail.com>, Christophe Leroy <christophe.leroy@csgroup.eu>, Michael Ellerman <mpe@ellerman.id.au>, Christophe JAILLET <christophe.jaillet@wanadoo.fr>
In-Reply-To: <7b8b5915a2c7c1616b33e8433ebe0a0bf07070a2.1665312579.git.christophe.jaillet@wanadoo.fr>
References: <7b8b5915a2c7c1616b33e8433ebe0a0bf07070a2.1665312579.git.christophe.jaillet@wanadoo.fr>
Subject: Re: [PATCH] powerpc/sysdev: Remove some duplicate prefix in some messages
Message-Id: <166980024656.3017288.14591621572057347121.b4-ty@ellerman.id.au>
Date: Wed, 30 Nov 2022 20:24:06 +1100
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
Cc: kernel-janitors@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev" <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Sun, 9 Oct 2022 12:49:50 +0200, Christophe JAILLET wrote:
> At the beginning of the file, we have:
>    #define pr_fmt(fmt) "xive: " fmt
> 
> So, there is no need to duplicate "XIVE:" in debug and error messages.
> 
> For the records, these useless prefix have been added in commit
> 5af50993850a ("KVM: PPC: Book3S HV: Native usage of the XIVE interrupt
> controller")
> 
> [...]

Applied to powerpc/next.

[1/1] powerpc/sysdev: Remove some duplicate prefix in some messages
      https://git.kernel.org/powerpc/c/2cb1dfac6f792f9e4a092793215f0d26e9f8d5b2

cheers
