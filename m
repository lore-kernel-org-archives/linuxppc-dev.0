Return-Path: <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45709C10DC3
	for <linuxppc-dev@archiver.kernel.org>; Thu,  7 Dec 2023 12:52:06 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4SmDgT0F1xz754Q
	for <linuxppc-dev@archiver.kernel.org>; Thu,  7 Dec 2023 23:52:05 +1100 (AEDT)
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4SmDVw6cpRz3dHc
	for <linuxppc-dev@lists.ozlabs.org>; Thu,  7 Dec 2023 23:44:40 +1100 (AEDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4SmDVw5Qlmz4xSc;
	Thu,  7 Dec 2023 23:44:40 +1100 (AEDT)
From: Michael Ellerman <patch-notifications@ellerman.id.au>
To: fbarrat@linux.ibm.com, ajd@linux.ibm.com, arnd@arndb.de, gregkh@linuxfoundation.org, Li zeming <zeming@nfschina.com>
In-Reply-To: <20231113012202.7887-1-zeming@nfschina.com>
References: <20231113012202.7887-1-zeming@nfschina.com>
Subject: Re: [PATCH] misc: ocxl: afu_irq: Remove unnecessary (void*) conversions
Message-Id: <170195271157.2310221.15419175340995819525.b4-ty@ellerman.id.au>
Date: Thu, 07 Dec 2023 23:38:31 +1100
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
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev" <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Mon, 13 Nov 2023 09:22:02 +0800, Li zeming wrote:
> The irq pointer does not need to cast the type.
> 
> 

Applied to powerpc/next.

[1/1] misc: ocxl: afu_irq: Remove unnecessary (void*) conversions
      https://git.kernel.org/powerpc/c/84ba5d3675e23e6fa824a2268c5b6a04b52dde4d

cheers
