Return-Path: <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C91FBC7619A
	for <linuxppc-dev@archiver.kernel.org>; Thu,  6 Apr 2023 01:20:09 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4PsNw82XvHz3frZ
	for <linuxppc-dev@archiver.kernel.org>; Thu,  6 Apr 2023 11:20:08 +1000 (AEST)
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4PsNk66KvBz3fJ6
	for <linuxppc-dev@lists.ozlabs.org>; Thu,  6 Apr 2023 11:11:26 +1000 (AEST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4PsNk31rdSz4xGN;
	Thu,  6 Apr 2023 11:11:23 +1000 (AEST)
From: Michael Ellerman <patch-notifications@ellerman.id.au>
To: benh@kernel.crashing.org, u.kleine-koenig@pengutronix.de, mpe@ellerman.id.au, benjamin.mugnier@foss.st.com, cminyard@mvista.com, khalasa@piap.pl, linuxppc-dev@lists.ozlabs.org, Liang He <windhl@126.com>
In-Reply-To: <20230330033558.2562778-1-windhl@126.com>
References: <20230330033558.2562778-1-windhl@126.com>
Subject: Re: [PATCH] macintosh/windfarm_smu_sat: Add missing of_node_put()
Message-Id: <168074339922.3678997.11492041621067175067.b4-ty@ellerman.id.au>
Date: Thu, 06 Apr 2023 11:09:59 +1000
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
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev" <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Thu, 30 Mar 2023 11:35:58 +0800, Liang He wrote:
> We call of_node_get() in wf_sat_probe() after sat is created,
> so we need the of_node_put() before *kfree(sat)*.
> 
> 

Applied to powerpc/next.

[1/1] macintosh/windfarm_smu_sat: Add missing of_node_put()
      https://git.kernel.org/powerpc/c/631cf002826007ab7415258ee647dcaf8845ad5a

cheers
