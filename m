Return-Path: <SRS0=5aIK=N3=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42DBAC43441
	for <linuxppc-dev@archiver.kernel.org>; Fri, 16 Nov 2018 01:52:28 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D882F208A3
	for <linuxppc-dev@archiver.kernel.org>; Fri, 16 Nov 2018 01:52:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D882F208A3
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=icloud.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42x1Sn6JLhzF3hS
	for <linuxppc-dev@archiver.kernel.org>; Fri, 16 Nov 2018 12:52:25 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=fail (p=quarantine dis=none) header.from=icloud.com
Authentication-Results: lists.ozlabs.org;
 spf=softfail (mailfrom) smtp.mailfrom=icloud.com
 (client-ip=220.244.226.126; helo=mail16.tpgi.com.au;
 envelope-from=sjdavies2@icloud.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dmarc=fail (p=quarantine dis=none)
 header.from=icloud.com
X-Greylist: delayed 624 seconds by postgrey-1.36 at bilbo;
 Fri, 16 Nov 2018 12:50:42 AEDT
Received: from mail16.tpgi.com.au (smtp-out16.tpgi.com.au [220.244.226.126])
 by lists.ozlabs.org (Postfix) with ESMTP id 42x1Qp6CRVzF3gP
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 16 Nov 2018 12:50:41 +1100 (AEDT)
X-TPG-Antivirus: Passed
X-TPG-Abuse: host=110-175-172-80.tpgi.com.au; ip=110.175.172.80;
 date=Fri, 16 Nov 2018 12:33:24 +1100
Received: from 192-168-1-98.tpgi.com.au (110-175-172-80.tpgi.com.au
 [110.175.172.80])
 by mail16.tpgi.com.au (envelope-from sjdavies2@icloud.com) (8.14.3/8.14.3)
 with ESMTP id wAG1XOH0013410
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 16 Nov 2018 12:33:24 +1100
From: Stephen Davies <sjdavies2@icloud.com>
Content-Type: text/plain;
	charset=us-ascii
Content-Transfer-Encoding: 7bit
Mime-Version: 1.0 (Mac OS X Mail 11.5 \(3445.9.1\))
Subject: subscribe
Message-Id: <0C59F064-9FBF-4070-BC8F-3DBC62D389E6@icloud.com>
Date: Fri, 16 Nov 2018 12:33:24 +1100
To: linuxppc-dev@lists.ozlabs.org
X-Mailer: Apple Mail (2.3445.9.1)
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

subscribe
