Return-Path: <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2688C433FE
	for <linuxppc-dev@archiver.kernel.org>; Wed, 30 Nov 2022 09:33:50 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4NMYtP0Nqxz3fN2
	for <linuxppc-dev@archiver.kernel.org>; Wed, 30 Nov 2022 20:33:49 +1100 (AEDT)
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4NMYqd0Symz2xVr
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 30 Nov 2022 20:31:25 +1100 (AEDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4NMYqc69sCz4xN8;
	Wed, 30 Nov 2022 20:31:24 +1100 (AEDT)
From: Michael Ellerman <patch-notifications@ellerman.id.au>
To: Haowen Bai <baihaowen@meizu.com>, masahiroy@kernel.org, benh@kernel.crashing.org, adobriyan@gmail.com
In-Reply-To: <1647484953-15249-1-git-send-email-baihaowen@meizu.com>
References: <1647484953-15249-1-git-send-email-baihaowen@meizu.com>
Subject: Re: [PATCH] macintosh: windfarm_pm91: Fix warning comparing pointer to 0
Message-Id: <166980021800.3017288.6852877951128523618.b4-ty@ellerman.id.au>
Date: Wed, 30 Nov 2022 20:23:38 +1100
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
Sender: "Linuxppc-dev" <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Thu, 17 Mar 2022 10:42:33 +0800, Haowen Bai wrote:
> Avoid pointer type value compared with 0 to make code clear.
> 
> 

Applied to powerpc/next.

[1/1] macintosh: windfarm_pm91: Fix warning comparing pointer to 0
      https://git.kernel.org/powerpc/c/88316944c3b3aa3ce3249c51689ef1621049df9d

cheers
