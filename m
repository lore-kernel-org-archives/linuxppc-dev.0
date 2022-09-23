Return-Path: <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E44A5C6FA82
	for <linuxppc-dev@archiver.kernel.org>; Fri, 23 Sep 2022 11:15:17 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4MYqLr3w6Zz3fCR
	for <linuxppc-dev@archiver.kernel.org>; Fri, 23 Sep 2022 21:15:16 +1000 (AEST)
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4MYqKg6BCDz3c8T
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 23 Sep 2022 21:14:15 +1000 (AEST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4MYqKf4fsdz4xGD;
	Fri, 23 Sep 2022 21:14:14 +1000 (AEST)
From: Michael Ellerman <patch-notifications@ellerman.id.au>
To: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, Zheng Yongjun <zhengyongjun3@huawei.com>
In-Reply-To: <20220906141703.118192-1-zhengyongjun3@huawei.com>
References: <20220906141703.118192-1-zhengyongjun3@huawei.com>
Subject: Re: [PATCH -next] powerpc/powernv: add missing of_node_put() in opal_export_attrs()
Message-Id: <166393161547.498456.17807482481125185495.b4-ty@ellerman.id.au>
Date: Fri, 23 Sep 2022 21:13:35 +1000
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
Cc: npiggin@gmail.com
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev" <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Tue, 6 Sep 2022 14:17:03 +0000, Zheng Yongjun wrote:
> After using 'np' returned by of_find_node_by_path(), of_node_put()
> need be called to decrease the refcount.
> 
> 

Applied to powerpc/next.

[1/1] powerpc/powernv: add missing of_node_put() in opal_export_attrs()
      https://git.kernel.org/powerpc/c/71a92e99c47900cc164620948b3863382cec4f1a

cheers
