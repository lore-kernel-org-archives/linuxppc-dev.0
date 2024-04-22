Return-Path: <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3FEA9C4345F
	for <linuxppc-dev@archiver.kernel.org>; Mon, 22 Apr 2024 09:22:07 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4VNKWx5Tgmz3dSZ
	for <linuxppc-dev@archiver.kernel.org>; Mon, 22 Apr 2024 19:22:05 +1000 (AEST)
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4VNKWV1ChKz3bsT
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 22 Apr 2024 19:21:42 +1000 (AEST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4VNKWT4xXkz4wyj;
	Mon, 22 Apr 2024 19:21:41 +1000 (AEST)
From: Michael Ellerman <patch-notifications@ellerman.id.au>
To: Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>, "Naveen N. Rao" <naveen.n.rao@linux.ibm.com>, Nathan Lynch <nathanl@linux.ibm.com>
In-Reply-To: <20240404-papr-vpd-test-uninit-lc-v2-1-37bff46c65a5@linux.ibm.com>
References: <20240404-papr-vpd-test-uninit-lc-v2-1-37bff46c65a5@linux.ibm.com>
Subject: Re: [PATCH v2] selftests/powerpc/papr-vpd: Fix missing variable initialization
Message-Id: <171377768069.1735812.14076402790807301778.b4-ty@ellerman.id.au>
Date: Mon, 22 Apr 2024 19:21:20 +1000
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
Cc: linuxppc-dev@lists.ozlabs.org, Geetika Moolchandani <geetika@linux.ibm.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev" <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Thu, 04 Apr 2024 17:02:09 -0500, Nathan Lynch wrote:
> The "close handle without consuming VPD" testcase has inconsistent
> results because it fails to initialize the location code object it
> passes to ioctl() to create a VPD handle. Initialize the location code
> to the empty string as intended.
> 
> 

Applied to powerpc/fixes.

[1/1] selftests/powerpc/papr-vpd: Fix missing variable initialization
      https://git.kernel.org/powerpc/c/210cfef579260ed6c3b700e7baeae51a5e183f43

cheers
