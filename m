Return-Path: <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2FBDEC433FE
	for <linuxppc-dev@archiver.kernel.org>; Wed, 30 Nov 2022 09:46:59 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4NMZ9Y52Hhz3gqY
	for <linuxppc-dev@archiver.kernel.org>; Wed, 30 Nov 2022 20:46:57 +1100 (AEDT)
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4NMYtd5C8Lz3fPM
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 30 Nov 2022 20:34:01 +1100 (AEDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4NMYtd3Mkmz4xZl;
	Wed, 30 Nov 2022 20:34:01 +1100 (AEDT)
From: Michael Ellerman <patch-notifications@ellerman.id.au>
To: linux-kernel@vger.kernel.org, Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20221124061918.1967-1-rdunlap@infradead.org>
References: <20221124061918.1967-1-rdunlap@infradead.org>
Subject: Re: [PATCH] powerpc/mpc52xx_lpbfifo: fix all kernel-doc warnings
Message-Id: <166980022198.3017288.13254869801146755533.b4-ty@ellerman.id.au>
Date: Wed, 30 Nov 2022 20:23:41 +1100
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
Cc: Anatolij Gustschin <agust@denx.de>, kernel test robot <lkp@intel.com>, John Bonesio <bones@secretlab.ca>, Mauro Carvalho Chehab <mchehab@kernel.org>, linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev" <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Wed, 23 Nov 2022 22:19:18 -0800, Randy Dunlap wrote:
> Fix multiple kernel-doc warnings in mpc52xx_lpbfifo.c:
> 
> arch/powerpc/platforms/52xx/mpc52xx_lpbfifo.c:377: warning: expecting prototype for mpc52xx_lpbfifo_bcom_poll(). Prototype was for mpc52xx_lpbfifo_poll() instead
> 
> mpc52xx_lpbfifo.c:221: warning: No description found for return value of 'mpc52xx_lpbfifo_irq'
> mpc52xx_lpbfifo.c:327: warning: No description found for return value of 'mpc52xx_lpbfifo_bcom_irq'
> mpc52xx_lpbfifo.c:398: warning: No description found for return value of 'mpc52xx_lpbfifo_submit'
> 
> [...]

Applied to powerpc/next.

[1/1] powerpc/mpc52xx_lpbfifo: fix all kernel-doc warnings
      https://git.kernel.org/powerpc/c/4562bffb83b88e61ea9c9912e50efbd5a941f0b3

cheers
