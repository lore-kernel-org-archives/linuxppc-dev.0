Return-Path: <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25989C433EF
	for <linuxppc-dev@archiver.kernel.org>; Sat, 12 Mar 2022 10:33:22 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4KFzfS5w9bz3dN7
	for <linuxppc-dev@archiver.kernel.org>; Sat, 12 Mar 2022 21:33:20 +1100 (AEDT)
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4KFzbd1rDbz30D5
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 12 Mar 2022 21:30:53 +1100 (AEDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4KFzbb5Dq1z4xLX;
 Sat, 12 Mar 2022 21:30:51 +1100 (AEDT)
From: Michael Ellerman <patch-notifications@ellerman.id.au>
To: benh@kernel.crashing.org, mpe@ellerman.id.au, christophe.leroy@csgroup.eu,
 wen.yang99@zte.com.cn, Hangyu Hua <hbh25y@gmail.com>, peng.hao2@zte.com.cn,
 paulus@samba.org
In-Reply-To: <20220223070223.26845-1-hbh25y@gmail.com>
References: <20220223070223.26845-1-hbh25y@gmail.com>
Subject: Re: [PATCH] powerpc: 8xx: fix a return value error in mpc8xx_pic_init
Message-Id: <164708099004.827774.1268843120953006497.b4-ty@ellerman.id.au>
Date: Sat, 12 Mar 2022 21:29:50 +1100
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

On Wed, 23 Feb 2022 15:02:23 +0800, Hangyu Hua wrote:
> mpc8xx_pic_init() should return -ENOMEM instead of 0 when
> irq_domain_add_linear() return NULL. This cause mpc8xx_pics_init to continue
> executing even if mpc8xx_pic_host is NULL.
> 
> 

Applied to powerpc/next.

[1/1] powerpc: 8xx: fix a return value error in mpc8xx_pic_init
      https://git.kernel.org/powerpc/c/3fd46e551f67f4303c3276a0d6cd20baf2d192c4

cheers
