Return-Path: <SRS0=TQYx=NT=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F70EC0044C
	for <linuxppc-dev@archiver.kernel.org>; Thu,  8 Nov 2018 00:40:40 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B906C2077B
	for <linuxppc-dev@archiver.kernel.org>; Thu,  8 Nov 2018 00:40:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=ozlabs.org header.i=@ozlabs.org header.b="jKLOt57/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B906C2077B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ozlabs.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42r4Fd5ThgzF3LL
	for <linuxppc-dev@archiver.kernel.org>; Thu,  8 Nov 2018 11:40:37 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=ozlabs.org
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; secure) header.d=ozlabs.org header.i=@ozlabs.org header.b="jKLOt57/";
	dkim-atps=neutral
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42r4C200sQzDqfY
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  8 Nov 2018 11:38:22 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=ozlabs.org
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 secure) header.d=ozlabs.org header.i=@ozlabs.org header.b="jKLOt57/"; 
 dkim-atps=neutral
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPSA id 42r4Bx3kTxz9s8F;
 Thu,  8 Nov 2018 11:38:17 +1100 (AEDT)
Authentication-Results: ozlabs.org;
 dmarc=none (p=none dis=none) header.from=ozlabs.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ozlabs.org; s=201707;
 t=1541637501; bh=6AOs0MPrpbhYm3CVi0be+MvcPV9W1lEqIQGPbZZcjhg=;
 h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
 b=jKLOt57/b2Sdo77Kf53XZAk+5FN7nV1amNHW7ZZCTNS00SUU5pwByVmp0QrQYHB0O
 MqlbMonNh2Vhz0X9wtXc98MU9R6DqDUhL0sIEefd3X0ECkoMx5srYy43QFNJkGGJIQ
 XktI4RNXUFkGmA3zIkkXqRSnXDleNMnfaxLe1hV46HMqcJF+5CpvAo091hi7o6WTVx
 iBOcOsTNSVj6336qUcyHP4ZicTfclsKnwilTNR7YlFRaM/NeAw9NND59HVjDd6aAnQ
 vX10lzWH0ld/CHjjN5zxfCRGHQtxWflS88JmrQ7PA9e9rbM5Ii/GjtLoe72kbpY2Ft
 538go9HG8C/JQ==
Subject: Re: [PATCH] Documentation: fix spelling mistake, EACCESS -> EACCES
To: Jonathan Corbet <corbet@lwn.net>, Colin King <colin.king@canonical.com>
References: <20181026172549.3628-1-colin.king@canonical.com>
 <20181107153104.71eddf4d@lwn.net>
From: Jeremy Kerr <jk@ozlabs.org>
Message-ID: <d1048515-239a-2686-e897-fb2a2b8d180f@ozlabs.org>
Date: Thu, 8 Nov 2018 08:38:15 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20181107153104.71eddf4d@lwn.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
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
Cc: kernel-janitors@vger.kernel.org, linux-doc@vger.kernel.org,
 David Airlie <airlied@linux.ie>, linuxppc-dev@lists.ozlabs.org,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 linux-kernel@vger.kernel.org, Michael Ellerman <michael@ellerman.id.au>,
 Maxime Ripard <maxime.ripard@bootlin.com>, Sean Paul <sean@poorly.run>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Hi Jon,

>> Signed-off-by: Colin Ian King <colin.king@canonical.com>
>> ---
>>   Documentation/filesystems/spufs.txt | 2 +-
>>   Documentation/gpu/drm-uapi.rst      | 4 ++--
>>   2 files changed, 3 insertions(+), 3 deletions(-)
> 
> Applied, thanks.
> 
> This is the first patch to spufs.txt since 2006...I wonder if that stuff
> is being used by anybody...

Anyone who is using the vector processors on the Cell BE processors will
be using it. However, that hardware is becoming pretty rare now.

We'll want to remove the spufs bits if/when we drop support for the cell
platforms (IBM QSxx, PS3, celleb). mpe: any ides on that? Do you have a 
policy for dropping platform support?

Cheers,


Jeremy
