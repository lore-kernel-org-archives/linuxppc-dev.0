Return-Path: <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2C7EC83F29
	for <linuxppc-dev@archiver.kernel.org>; Thu, 31 Aug 2023 04:11:54 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4RbnmT4j9Jz3dhP
	for <linuxppc-dev@archiver.kernel.org>; Thu, 31 Aug 2023 14:11:53 +1000 (AEST)
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4RbncP599jz3bxZ
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 31 Aug 2023 14:04:53 +1000 (AEST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4RbncP1vjGz4x3v;
	Thu, 31 Aug 2023 14:04:53 +1000 (AEST)
From: Michael Ellerman <patch-notifications@ellerman.id.au>
To: mahesh@linux.ibm.com, oohall@gmail.com, npiggin@gmail.com, christophe.leroy@csgroup.eu, Jialin Zhang <zhangjialin11@huawei.com>
In-Reply-To: <20230815023303.3515503-1-zhangjialin11@huawei.com>
References: <20230815023303.3515503-1-zhangjialin11@huawei.com>
Subject: Re: [PATCH] powerpc/eeh: Use pci_dev_id() to simplify the code
Message-Id: <169345455030.11824.1381978800667539791.b4-ty@ellerman.id.au>
Date: Thu, 31 Aug 2023 14:02:30 +1000
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
Cc: linuxppc-dev@lists.ozlabs.org, liwei391@huawei.com, wangxiongfeng2@huawei.com
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev" <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Tue, 15 Aug 2023 10:33:03 +0800, Jialin Zhang wrote:
> PCI core API pci_dev_id() can be used to get the BDF number for a pci
> device. We don't need to compose it mannually. Use pci_dev_id() to
> simplify the code a little bit.
> 
> 

Applied to powerpc/next.

[1/1] powerpc/eeh: Use pci_dev_id() to simplify the code
      https://git.kernel.org/powerpc/c/664ec38673bef18bbcc4ede02274c8977470823f

cheers
