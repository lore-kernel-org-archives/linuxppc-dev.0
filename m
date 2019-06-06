Return-Path: <SRS0=nl2z=UF=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCC9DC04AB5
	for <linuxppc-dev@archiver.kernel.org>; Thu,  6 Jun 2019 13:57:17 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 87B3720652
	for <linuxppc-dev@archiver.kernel.org>; Thu,  6 Jun 2019 13:57:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 87B3720652
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 45KRzv0JyszDqhK
	for <linuxppc-dev@archiver.kernel.org>; Thu,  6 Jun 2019 23:57:15 +1000 (AEST)
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 45KRDP5YMJzDqhD
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  6 Jun 2019 23:23:01 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 dmarc=fail (p=none dis=none) header.from=gmail.com
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 by bilbo.ozlabs.org (Postfix) with ESMTP id 45KRDP3D6Wz8tSD
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  6 Jun 2019 23:23:01 +1000 (AEST)
Received: by ozlabs.org (Postfix)
 id 45KRDP2DMfz9sNT; Thu,  6 Jun 2019 23:23:01 +1000 (AEST)
Authentication-Results: ozlabs.org;
 spf=softfail (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=162.253.133.57; helo=n7.nabble.com;
 envelope-from=girramsivakrishna@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: ozlabs.org;
 dmarc=fail (p=none dis=none) header.from=gmail.com
Received: from n7.nabble.com (n7.nabble.com [162.253.133.57])
 by ozlabs.org (Postfix) with ESMTP id 45KRDN4Bh3z9sDX
 for <linuxppc-dev@ozlabs.org>; Thu,  6 Jun 2019 23:23:00 +1000 (AEST)
Received: from n7.nabble.com (localhost [127.0.0.1])
 by n7.nabble.com (Postfix) with ESMTP id A31E8CA5BBDC
 for <linuxppc-dev@ozlabs.org>; Thu,  6 Jun 2019 06:14:50 -0700 (MST)
Date: Thu, 6 Jun 2019 06:14:50 -0700 (MST)
From: siva krishna <girramsivakrishna@gmail.com>
To: linuxppc-dev@ozlabs.org
Message-ID: <1559826890592-0.post@n7.nabble.com>
In-Reply-To: <547eba1b0903232205uc3b6a78y6db7e7ce161bd39@mail.gmail.com>
References: <547eba1b0903180036m46f6ffc0g521a5081924a2613@mail.gmail.com>
 <4206182445660643B9AEB8D4E55BBD0A02B9DDEEB3@HERMES2>
 <547eba1b0903190132pfd11ad5ld4b1bffb6dc22758@mail.gmail.com>
 <547eba1b0903191819v5b03d38ci7a60839873e5bd66@mail.gmail.com>
 <4206182445660643B9AEB8D4E55BBD0A02B9DDEEB4@HERMES2>
 <547eba1b0903232205uc3b6a78y6db7e7ce161bd39@mail.gmail.com>
Subject: Re: spidev.c driver on the ppc8247 (kernel 2.6.27.19)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Mailman-Approved-At: Thu, 06 Jun 2019 23:54:36 +1000
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
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Hi ,

can you elobarate this ,meaning which file need to be modified etc .



--
Sent from: http://linuxppc.10917.n7.nabble.com/linuxppc-dev-f3.html
