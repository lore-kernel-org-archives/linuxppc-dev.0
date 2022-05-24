Return-Path: <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10BC9C433EF
	for <linuxppc-dev@archiver.kernel.org>; Tue, 24 May 2022 11:16:40 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4L6s8l3SYcz3dwG
	for <linuxppc-dev@archiver.kernel.org>; Tue, 24 May 2022 21:16:39 +1000 (AEST)
Received: from gandalf.ozlabs.org (mail.ozlabs.org
 [IPv6:2404:9400:2221:ea00::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4L6s7S0pdxz3blZ
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 24 May 2022 21:15:32 +1000 (AEST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4L6s7R6xbdz4xYX;
 Tue, 24 May 2022 21:15:31 +1000 (AEST)
From: Michael Ellerman <patch-notifications@ellerman.id.au>
To: cgel.zte@gmail.com, mpe@ellerman.id.au
In-Reply-To: <20220402013419.2410298-1-lv.ruyi@zte.com.cn>
References: <20220402013419.2410298-1-lv.ruyi@zte.com.cn>
Subject: Re: [PATCH] powerpc/sysdev: fix refcount leak in icp_opal_init()
Message-Id: <165339057736.1718562.8464783736668414946.b4-ty@ellerman.id.au>
Date: Tue, 24 May 2022 21:09:37 +1000
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
Cc: nick.child@ibm.com, Zeal Robot <zealci@zte.com.cn>,
 linux-kernel@vger.kernel.org, paulus@samba.org, maz@kernel.org,
 linuxppc-dev@lists.ozlabs.org, lv.ruyi@zte.com.cn
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Sat, 2 Apr 2022 01:34:19 +0000, cgel.zte@gmail.com wrote:
> From: Lv Ruyi <lv.ruyi@zte.com.cn>
> 
> The of_find_compatible_node() function returns a node pointer with
> refcount incremented, use of_node_put() on it when done.
> 
> 

Applied to powerpc/next.

[1/1] powerpc/sysdev: fix refcount leak in icp_opal_init()
      https://git.kernel.org/powerpc/c/5dd9e27ea4a39f7edd4bf81e9e70208e7ac0b7c9

cheers
