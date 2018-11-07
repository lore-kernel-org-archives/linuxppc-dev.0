Return-Path: <SRS0=kkFw=NS=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94A21C0044C
	for <linuxppc-dev@archiver.kernel.org>; Wed,  7 Nov 2018 22:33:32 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E22F92086C
	for <linuxppc-dev@archiver.kernel.org>; Wed,  7 Nov 2018 22:33:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E22F92086C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lwn.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42r1Qx4PBJzF3K3
	for <linuxppc-dev@archiver.kernel.org>; Thu,  8 Nov 2018 09:33:29 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=lwn.net
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=lwn.net
 (client-ip=45.79.88.28; helo=ms.lwn.net; envelope-from=corbet@lwn.net;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=lwn.net
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42r1NL50K0zF38H
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  8 Nov 2018 09:31:07 +1100 (AEDT)
Received: from lwn.net (localhost [127.0.0.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ms.lwn.net (Postfix) with ESMTPSA id 3D4642ED;
 Wed,  7 Nov 2018 22:31:05 +0000 (UTC)
Date: Wed, 7 Nov 2018 15:31:04 -0700
From: Jonathan Corbet <corbet@lwn.net>
To: Colin King <colin.king@canonical.com>
Subject: Re: [PATCH] Documentation: fix spelling mistake, EACCESS -> EACCES
Message-ID: <20181107153104.71eddf4d@lwn.net>
In-Reply-To: <20181026172549.3628-1-colin.king@canonical.com>
References: <20181026172549.3628-1-colin.king@canonical.com>
Organization: LWN.net
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
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
Cc: kernel-janitors@vger.kernel.org, linux-doc@vger.kernel.org,
 David Airlie <airlied@linux.ie>, linuxppc-dev@lists.ozlabs.org,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 linux-kernel@vger.kernel.org, Maxime Ripard <maxime.ripard@bootlin.com>,
 Jeremy Kerr <jk@ozlabs.org>, Sean Paul <sean@poorly.run>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Fri, 26 Oct 2018 18:25:49 +0100
Colin King <colin.king@canonical.com> wrote:

> Trivial fix to a spelling mistake of the error access name EACCESS,
> rename to EACCES
> 
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> ---
>  Documentation/filesystems/spufs.txt | 2 +-
>  Documentation/gpu/drm-uapi.rst      | 4 ++--
>  2 files changed, 3 insertions(+), 3 deletions(-)

Applied, thanks.  

This is the first patch to spufs.txt since 2006...I wonder if that stuff
is being used by anybody...

jon
