Return-Path: <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15F80C7619A
	for <linuxppc-dev@archiver.kernel.org>; Thu,  6 Apr 2023 00:28:26 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4PsMmS4Fnzz3fjc
	for <linuxppc-dev@archiver.kernel.org>; Thu,  6 Apr 2023 10:28:24 +1000 (AEST)
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4PsMlw0d3fz3fdk
	for <linuxppc-dev@lists.ozlabs.org>; Thu,  6 Apr 2023 10:27:56 +1000 (AEST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4PsMls5tn2z4x1N;
	Thu,  6 Apr 2023 10:27:53 +1000 (AEST)
From: Michael Ellerman <patch-notifications@ellerman.id.au>
To: linuxppc-dev@lists.ozlabs.org, mpe@ellerman.id.au, npiggin@gmail.com, christophe.leroy@csgroup.eu, "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
In-Reply-To: <20230404041433.1781804-1-aneesh.kumar@linux.ibm.com>
References: <20230404041433.1781804-1-aneesh.kumar@linux.ibm.com>
Subject: Re: [PATCH v2] powerpc/papr_scm: Update the NUMA distance table for the target node
Message-Id: <168074081765.3666874.4766413676138573175.b4-ty@ellerman.id.au>
Date: Thu, 06 Apr 2023 10:26:57 +1000
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
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev" <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Tue, 04 Apr 2023 09:44:33 +0530, Aneesh Kumar K.V wrote:
> platform device helper routines won't update the NUMA distance table
> while creating a platform device, even if the device is present on
> a NUMA node that doesn't have memory or CPU. This is especially true
> for pmem devices. If the target node of the pmem device is not online, we
> find the nearest online node to the device and associate the pmem
> device with that online node. To find the nearest online node, we should
> have the numa distance table updated correctly. Update the distance
> information during the device probe.
> 
> [...]

Applied to powerpc/fixes.

[1/1] powerpc/papr_scm: Update the NUMA distance table for the target node
      https://git.kernel.org/powerpc/c/b277fc793daf258877b4c0744b52f69d6e6ba22e

cheers
