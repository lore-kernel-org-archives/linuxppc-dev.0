Return-Path: <SRS0=8b8/=EE=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 257ACC4742C
	for <linuxppc-dev@archiver.kernel.org>; Thu, 29 Oct 2020 23:48:03 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2589020720
	for <linuxppc-dev@archiver.kernel.org>; Thu, 29 Oct 2020 23:48:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2589020720
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=russell.cc
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4CMhvh10CVzDqQ8
	for <linuxppc-dev@archiver.kernel.org>; Fri, 30 Oct 2020 10:48:00 +1100 (AEDT)
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4CMhnH0GxTzDqXL
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 30 Oct 2020 10:42:27 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=russell.cc
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 by bilbo.ozlabs.org (Postfix) with ESMTP id 4CMhnD29JWz8tDR
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 30 Oct 2020 10:42:24 +1100 (AEDT)
Received: by ozlabs.org (Postfix)
 id 4CMhnC4qY6z9sSn; Fri, 30 Oct 2020 10:42:23 +1100 (AEDT)
Authentication-Results: ozlabs.org;
 spf=neutral (access neither permitted nor denied)
 smtp.mailfrom=russell.cc (client-ip=140.211.168.157; helo=fox;
 envelope-from=snowpatch@russell.cc; receiver=<UNKNOWN>)
Authentication-Results: ozlabs.org;
 dmarc=none (p=none dis=none) header.from=russell.cc
Received: from fox (140-211-168-157-openstack.osuosl.org [140.211.168.157])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 4CMhn971yyz9sSG
 for <linuxppc-dev@ozlabs.org>; Fri, 30 Oct 2020 10:42:21 +1100 (AEDT)
Received: from fox (ip6-localhost [::1])
 by fox (OpenSMTPD) with ESMTP id d05f6209;
 Thu, 29 Oct 2020 23:42:20 +0000 (UTC)
Subject: Test Results: RE: [V2, 07/18] csky/mm/highmem: Switch to generic kmap
 atomic
To: "Thomas Gleixner" <tglx@linutronix.de>, <linuxppc-dev@ozlabs.org>
From: <snowpatch@russell.cc>
In-Reply-To: <20201029222651.303553207@linutronix.de>
Date: Thu, 29 Oct 2020 23:42:20 -0000
MIME-Version: 1.0
Message-ID: <0437f9f6-bc28-4d39-822e-aaa29c691958.lettre@localhost>
Content-Type: multipart/mixed; boundary=8bZoc6CkulnrCOplodFAvgmTVd0tLM
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


--8bZoc6CkulnrCOplodFAvgmTVd0tLM
Content-Type: text/plain; charset=utf-8

Thanks for your contribution, unfortunately we've found some issues.

Your patch failed to apply to any branch.



--8bZoc6CkulnrCOplodFAvgmTVd0tLM--

