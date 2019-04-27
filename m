Return-Path: <SRS0=Akx6=S5=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7144C43219
	for <linuxppc-dev@archiver.kernel.org>; Sat, 27 Apr 2019 05:11:53 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1F791206BF
	for <linuxppc-dev@archiver.kernel.org>; Sat, 27 Apr 2019 05:11:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1F791206BF
Authentication-Results: mail.kernel.org; dmarc=pass (p=none dis=none) header.from=patchwork.ozlabs.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44rfD73tsKzDqZL
	for <linuxppc-dev@archiver.kernel.org>; Sat, 27 Apr 2019 15:11:51 +1000 (AEST)
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44rcnk3YL3zDqVT
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 27 Apr 2019 14:07:22 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=patchwork.ozlabs.org
Received: from bilbo.ozlabs.org (localhost [IPv6:::1])
 by ozlabs.org (Postfix) with ESMTP id 44rcnk2Jh9z9sSF
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 27 Apr 2019 14:07:22 +1000 (AEST)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none)
 header.from=patchwork.ozlabs.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: [linuxppc-dev] Patch notification: 3 patches updated
From: Patchwork <patchwork@patchwork.ozlabs.org>
To: linuxppc-dev@lists.ozlabs.org
Date: Sat, 27 Apr 2019 04:07:22 -0000
Message-ID: <20190427040722.23711.34559@bilbo.ozlabs.org>
Precedence: bulk
X-Mailman-Approved-At: Sat, 27 Apr 2019 15:04:36 +1000
X-BeenThere: linuxppc-dev@lists.ozlabs.org
X-Mailman-Version: 2.1.29
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

Hello,

The following patches (submitted by you) have been updated in Patchwork:

 * linuxppc-dev: crash in ppc4xx-rng on canyonland
     - http://patchwork.ozlabs.org/patch/608253/
     - for: Linux PPC development
    was: New
    now: Not Applicable

 * linuxppc-dev: crash in ppc4xx-rng on canyonland
     - http://patchwork.ozlabs.org/patch/602137/
     - for: Linux PPC development
    was: New
    now: Not Applicable

 * linuxppc-dev: crash in ppc4xx-rng on canyonland
     - http://patchwork.ozlabs.org/patch/611704/
     - for: Linux PPC development
    was: New
    now: Not Applicable

This email is a notification only - you do not need to respond.

Happy patchworking.

--

This is an automated mail sent by the Patchwork system at
patchwork.ozlabs.org. To stop receiving these notifications, edit
your mail settings at:
  http://patchwork.ozlabs.org/mail/
