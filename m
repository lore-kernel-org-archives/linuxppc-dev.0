Return-Path: <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6A68C433EF
	for <linuxppc-dev@archiver.kernel.org>; Wed, 16 Feb 2022 12:34:36 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4JzHTR0QY7z3dkw
	for <linuxppc-dev@archiver.kernel.org>; Wed, 16 Feb 2022 23:34:35 +1100 (AEDT)
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4JzHNT4B5sz3cR4
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 16 Feb 2022 23:30:17 +1100 (AEDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4JzHNT6PLNz4xv5;
 Wed, 16 Feb 2022 23:30:17 +1100 (AEDT)
From: Michael Ellerman <patch-notifications@ellerman.id.au>
To: Ritesh Harjani <riteshh@linux.ibm.com>, linuxppc-dev@lists.ozlabs.org
In-Reply-To: <57242c1fe7aba6b7f0fcd0490303bfd5f222ee00.1631512686.git.riteshh@linux.ibm.com>
References: <57242c1fe7aba6b7f0fcd0490303bfd5f222ee00.1631512686.git.riteshh@linux.ibm.com>
Subject: Re: [PATCHv2] selftests/powerpc/copyloops: Add memmove_64 test
Message-Id: <164501435775.521186.12117089875046828615.b4-ty@ellerman.id.au>
Date: Wed, 16 Feb 2022 23:25:57 +1100
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
Cc: "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>,
 Vaibhav Jain <vaibhav@linux.ibm.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Mon, 13 Sep 2021 11:47:20 +0530, Ritesh Harjani wrote:
> While debugging an issue, we wanted to check whether the arch specific
> kernel memmove implementation is correct.
> This selftest could help test that.
> 
> 

Applied to powerpc/next.

[1/1] selftests/powerpc/copyloops: Add memmove_64 test
      https://git.kernel.org/powerpc/c/2504e5b9827f7fc76ed0e4593adc852ac7a19851

cheers
