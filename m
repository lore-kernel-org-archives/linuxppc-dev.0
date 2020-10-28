Return-Path: <SRS0=QTfK=ED=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9386AC4363A
	for <linuxppc-dev@archiver.kernel.org>; Wed, 28 Oct 2020 11:48:05 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E99B9246CB
	for <linuxppc-dev@archiver.kernel.org>; Wed, 28 Oct 2020 11:48:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E99B9246CB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=russell.cc
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4CLmzP07DbzDqST
	for <linuxppc-dev@archiver.kernel.org>; Wed, 28 Oct 2020 22:48:01 +1100 (AEDT)
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4CLhVv2LhWzDqQl
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 28 Oct 2020 19:26:31 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=russell.cc
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 by bilbo.ozlabs.org (Postfix) with ESMTP id 4CLhVv0H5kz8t11
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 28 Oct 2020 19:26:31 +1100 (AEDT)
Received: by ozlabs.org (Postfix)
 id 4CLhVt6xs3z9sVX; Wed, 28 Oct 2020 19:26:30 +1100 (AEDT)
Authentication-Results: ozlabs.org;
 spf=neutral (access neither permitted nor denied)
 smtp.mailfrom=russell.cc (client-ip=140.211.168.157; helo=fox;
 envelope-from=snowpatch@russell.cc; receiver=<UNKNOWN>)
Authentication-Results: ozlabs.org;
 dmarc=none (p=none dis=none) header.from=russell.cc
X-Greylist: delayed 398 seconds by postgrey-1.36 at bilbo;
 Wed, 28 Oct 2020 19:26:30 AEDT
Received: from fox (140-211-168-157-openstack.osuosl.org [140.211.168.157])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 4CLhVt0kgWz9sV7
 for <linuxppc-dev@ozlabs.org>; Wed, 28 Oct 2020 19:26:29 +1100 (AEDT)
Received: from fox (ip6-localhost [::1])
 by fox (OpenSMTPD) with ESMTP id d9d6ea9a;
 Wed, 28 Oct 2020 08:19:48 +0000 (UTC)
Subject: Test Results: RE: powerpc: avoid broken GCC __attribute__((optimize))
To: "Ard Biesheuvel" <ardb@kernel.org>, <linuxppc-dev@ozlabs.org>
From: <snowpatch@russell.cc>
In-Reply-To: <20201028080433.26799-1-ardb@kernel.org>
Date: Wed, 28 Oct 2020 08:19:48 -0000
MIME-Version: 1.0
Message-ID: <1ec72dd0-653c-49e6-bc98-5eb277e8c7a8.lettre@localhost>
Content-Type: multipart/mixed; boundary=d9rsrrUMyxZkynvW3eZmZRJTsyTxGe
X-Mailman-Approved-At: Wed, 28 Oct 2020 22:46:08 +1100
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


--d9rsrrUMyxZkynvW3eZmZRJTsyTxGe
Content-Type: text/plain; charset=utf-8

Thanks for your contribution, unfortunately we've found some issues.

Your patch was successfully applied on branch powerpc/merge (8cb17737940b156329cb5210669b9c9b23f4dd56)

The test build-ppc64le reported the following: Build failed!

 Full log: https://openpower.xyz/job/snowpatch/job/snowpatch-linux-sparse/21048//artifact/linux/report.txt


Here's a preview of the log:

arch/powerpc/kernel/paca.c:244:25: error: expected '=', ',', ';', 'asm' or '__attribute__' before 'setup_paca'
  244 | void __nostackprotector setup_paca(struct paca_struct *new_paca)
      |                         ^~~~~~~~~~
make[2]: *** [scripts/Makefile.build:283: arch/powerpc/kernel/paca.o] Error 1
make[1]: *** [scripts/Makefile.build:500: arch/powerpc/kernel] Error 2
make[1]: *** Waiting for unfinished jobs....
make: *** [Makefile:1799: arch/powerpc] Error 2
make: *** Waiting for unfinished jobs....


The test build-ppc64be reported the following: Build failed!

 Full log: https://openpower.xyz/job/snowpatch/job/snowpatch-linux-sparse/21049//artifact/linux/report.txt


Here's a preview of the log:

arch/powerpc/kernel/paca.c:244:25: error: expected '=', ',', ';', 'asm' or '__attribute__' before 'setup_paca'
  244 | void __nostackprotector setup_paca(struct paca_struct *new_paca)
      |                         ^~~~~~~~~~
make[2]: *** [scripts/Makefile.build:283: arch/powerpc/kernel/paca.o] Error 1
make[1]: *** [scripts/Makefile.build:500: arch/powerpc/kernel] Error 2
make[1]: *** Waiting for unfinished jobs....
make: *** [Makefile:1799: arch/powerpc] Error 2
make: *** Waiting for unfinished jobs....


The test build-ppc64e reported the following: Build failed!

 Full log: https://openpower.xyz/job/snowpatch/job/snowpatch-linux-sparse/21050//artifact/linux/report.txt


Here's a preview of the log:

arch/powerpc/kernel/paca.c:244:25: error: expected '=', ',', ';', 'asm' or '__attribute__' before 'setup_paca'
  244 | void __nostackprotector setup_paca(struct paca_struct *new_paca)
      |                         ^~~~~~~~~~
make[2]: *** [scripts/Makefile.build:283: arch/powerpc/kernel/paca.o] Error 1
make[1]: *** [scripts/Makefile.build:500: arch/powerpc/kernel] Error 2
make[1]: *** Waiting for unfinished jobs....
make: *** [Makefile:1799: arch/powerpc] Error 2
make: *** Waiting for unfinished jobs....




--d9rsrrUMyxZkynvW3eZmZRJTsyTxGe--

