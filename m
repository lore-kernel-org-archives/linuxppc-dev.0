Return-Path: <SRS0=t5Ns=QU=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DFF6C282C2
	for <linuxppc-dev@archiver.kernel.org>; Wed, 13 Feb 2019 12:27:37 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 19E01222B2
	for <linuxppc-dev@archiver.kernel.org>; Wed, 13 Feb 2019 12:27:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 19E01222B2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=emerson.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43zzLZ0kFYzDqSs
	for <linuxppc-dev@archiver.kernel.org>; Wed, 13 Feb 2019 23:27:34 +1100 (AEDT)
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43zzHP6DSSzDqTF
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 Feb 2019 23:24:49 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 dmarc=fail (p=none dis=none) header.from=emerson.com
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 by bilbo.ozlabs.org (Postfix) with ESMTP id 43zzHP3jD3z8tQK
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 Feb 2019 23:24:49 +1100 (AEDT)
Received: by ozlabs.org (Postfix)
 id 43zzHP2JFkz9s7h; Wed, 13 Feb 2019 23:24:49 +1100 (AEDT)
Authentication-Results: ozlabs.org;
 spf=softfail (mailfrom) smtp.mailfrom=emerson.com
 (client-ip=162.253.133.57; helo=n7.nabble.com;
 envelope-from=sachin.gosavi@emerson.com; receiver=<UNKNOWN>)
Authentication-Results: ozlabs.org;
 dmarc=fail (p=none dis=none) header.from=emerson.com
Received: from n7.nabble.com (n7.nabble.com [162.253.133.57])
 by ozlabs.org (Postfix) with ESMTP id 43zzHN5yNfz9s4Z
 for <linuxppc-dev@ozlabs.org>; Wed, 13 Feb 2019 23:24:46 +1100 (AEDT)
Received: from n7.nabble.com (localhost [127.0.0.1])
 by n7.nabble.com (Postfix) with ESMTP id 34D8F9B5632C
 for <linuxppc-dev@ozlabs.org>; Wed, 13 Feb 2019 05:24:45 -0700 (MST)
Date: Wed, 13 Feb 2019 05:24:45 -0700 (MST)
From: sgosavi1 <Sachin.Gosavi@emerson.com>
To: linuxppc-dev@ozlabs.org
Message-ID: <1550060685213-0.post@n7.nabble.com>
In-Reply-To: <7c695098-8b2b-5af0-c961-f25457459f8e@c-s.fr>
References: <1550055691105-0.post@n7.nabble.com>
 <7c695098-8b2b-5af0-c961-f25457459f8e@c-s.fr>
Subject: Re: Kernel panic when loading the IDE controller driver
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
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
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

> What it the last linux version known to work properly?


We have used it successfully in the Linux-2.6.17.6 version. 


Thanks,
Sachin.



--
Sent from: http://linuxppc.10917.n7.nabble.com/linuxppc-dev-f3.html
