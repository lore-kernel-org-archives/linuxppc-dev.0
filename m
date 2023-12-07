Return-Path: <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8CEA3C4167B
	for <linuxppc-dev@archiver.kernel.org>; Thu,  7 Dec 2023 12:46:50 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4SmDYP20JYz3vt6
	for <linuxppc-dev@archiver.kernel.org>; Thu,  7 Dec 2023 23:46:49 +1100 (AEDT)
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4SmDVp0HwDz3dBn
	for <linuxppc-dev@lists.ozlabs.org>; Thu,  7 Dec 2023 23:44:34 +1100 (AEDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4SmDVl4Jpgz4xKl;
	Thu,  7 Dec 2023 23:44:31 +1100 (AEDT)
From: Michael Ellerman <patch-notifications@ellerman.id.au>
To: npiggin@gmail.com, christophe.leroy@csgroup.eu, fbarrat@linux.ibm.com, ajd@linux.ibm.com, arnd@arndb.de, gregkh@linuxfoundation.org, Zhao Ke <ke.zhao@shingroup.cn>
In-Reply-To: <20231129075845.57976-1-ke.zhao@shingroup.cn>
References: <20231129075845.57976-1-ke.zhao@shingroup.cn>
Subject: Re: [PATCH v2] powerpc: Add PVN support for HeXin C2000 processor
Message-Id: <170195271167.2310221.14120518840277202418.b4-ty@ellerman.id.au>
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
Cc: luming.yu@shingroup.cn, kvm@vger.kernel.org, dawei.li@shingroup.cn, linux-kernel@vger.kernel.org, shenghui.qu@shingroup.cn, linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev" <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Wed, 29 Nov 2023 15:58:45 +0800, Zhao Ke wrote:
> HeXin Tech Co. has applied for a new PVN from the OpenPower Community
> for its new processor C2000. The OpenPower has assigned a new PVN
> and this newly assigned PVN is 0x0066, add pvr register related
> support for this PVN.
> 
> 

Applied to powerpc/next.

[1/1] powerpc: Add PVN support for HeXin C2000 processor
      https://git.kernel.org/powerpc/c/e12d8e2602d2bcd26022eff3e2519d25925e760c

cheers
