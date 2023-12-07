Return-Path: <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00665C4167B
	for <linuxppc-dev@archiver.kernel.org>; Thu,  7 Dec 2023 12:51:39 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4SmDfy4z1Cz3w0J
	for <linuxppc-dev@archiver.kernel.org>; Thu,  7 Dec 2023 23:51:38 +1100 (AEDT)
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4SmDVv6lGQz3dKF
	for <linuxppc-dev@lists.ozlabs.org>; Thu,  7 Dec 2023 23:44:39 +1100 (AEDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4SmDVv5ZLnz4xS7;
	Thu,  7 Dec 2023 23:44:39 +1100 (AEDT)
From: Michael Ellerman <patch-notifications@ellerman.id.au>
To: linux-kernel@vger.kernel.org, Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20231201055159.8371-1-rdunlap@infradead.org>
References: <20231201055159.8371-1-rdunlap@infradead.org>
Subject: Re: [PATCH] powerpc/44x: select I2C for CURRITUCK
Message-Id: <170195271170.2310221.1804568232348474171.b4-ty@ellerman.id.au>
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
Cc: Alistair Popple <alistair@popple.id.au>, linuxppc-dev@lists.ozlabs.org, kernel test robot <lkp@intel.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev" <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Thu, 30 Nov 2023 21:51:59 -0800, Randy Dunlap wrote:
> Fix build errors when CURRITUCK=y and I2C is not builtin (=m or is
> not set). Fixes these build errors:
> 
> powerpc-linux-ld: arch/powerpc/platforms/44x/ppc476.o: in function `avr_halt_system':
> ppc476.c:(.text+0x58): undefined reference to `i2c_smbus_write_byte_data'
> powerpc-linux-ld: arch/powerpc/platforms/44x/ppc476.o: in function `ppc47x_device_probe':
> ppc476.c:(.init.text+0x18): undefined reference to `i2c_register_driver'
> 
> [...]

Applied to powerpc/next.

[1/1] powerpc/44x: select I2C for CURRITUCK
      https://git.kernel.org/powerpc/c/4a74197b65e69c46fe6e53f7df2f4d6ce9ffe012

cheers
