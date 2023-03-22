Return-Path: <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96770C6FD1F
	for <linuxppc-dev@archiver.kernel.org>; Wed, 22 Mar 2023 12:30:59 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4PhSW61CwGz3fW7
	for <linuxppc-dev@archiver.kernel.org>; Wed, 22 Mar 2023 23:30:58 +1100 (AEDT)
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4PhSR66NGbz3cdK
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 22 Mar 2023 23:27:30 +1100 (AEDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4PhSR06HqHz4xDr;
	Wed, 22 Mar 2023 23:27:24 +1100 (AEDT)
From: Michael Ellerman <patch-notifications@ellerman.id.au>
To: mpe@ellerman.id.au, Kajol Jain <kjain@linux.ibm.com>
In-Reply-To: <20230301170918.69176-1-kjain@linux.ibm.com>
References: <20230301170918.69176-1-kjain@linux.ibm.com>
Subject: Re: (subset) [PATCH 1/2] selftests/powerpc/pmu: Fix sample field check in the mmcra_thresh_marked_sample_test
Message-Id: <167948793440.559204.9338504502632395334.b4-ty@ellerman.id.au>
Date: Wed, 22 Mar 2023 23:25:34 +1100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
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
Cc: disgoel@linux.vnet.ibm.com, atrajeev@linux.vnet.ibm.com, linuxppc-dev@lists.ozlabs.org, maddy@linux.ibm.com, David Binderman <dcb314@hotmail.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev" <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Wed, 01 Mar 2023 22:39:17 +0530, Kajol Jain wrote:
> The testcase verifies the setting of different fields in Monitor Mode
> Control Register A (MMCRA). In the current code, EV_CODE_EXTRACT macro
> is used to extract the "sample" field, which then needs to be further
> processed to fetch rand_samp_elig and rand_samp_mode bits. But the
> current code is not passing valid sample field to EV_CODE_EXTRACT
> macro. Patch addresses this by fixing the input for EV_CODE_EXTRACT.
> 
> [...]

Patch 1 applied to powerpc/next.

[1/2] selftests/powerpc/pmu: Fix sample field check in the mmcra_thresh_marked_sample_test
      https://git.kernel.org/powerpc/c/8a32341cf04ba05974931b4664683c2c9fb84e56

cheers
