Return-Path: <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8B77C00140
	for <linuxppc-dev@archiver.kernel.org>; Tue,  2 Aug 2022 11:03:10 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4LxsXs3Rdqz3dxr
	for <linuxppc-dev@archiver.kernel.org>; Tue,  2 Aug 2022 21:03:09 +1000 (AEST)
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4LxsXS44RKz2xGd
	for <linuxppc-dev@lists.ozlabs.org>; Tue,  2 Aug 2022 21:02:48 +1000 (AEST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4LxsXS34fvz4wgn;
	Tue,  2 Aug 2022 21:02:48 +1000 (AEST)
From: Michael Ellerman <patch-notifications@ellerman.id.au>
To: mpe@ellerman.id.au, Athira Rajeev <atrajeev@linux.vnet.ibm.com>
In-Reply-To: <20220728163746.85062-1-atrajeev@linux.vnet.ibm.com>
References: <20220728163746.85062-1-atrajeev@linux.vnet.ibm.com>
Subject: Re: [PATCH] powerpc/perf: Include caps feature for power10 DD1 version
Message-Id: <165943814202.1061647.17909901455583348091.b4-ty@ellerman.id.au>
Date: Tue, 02 Aug 2022 21:02:22 +1000
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
Cc: kjain@linux.ibm.com, maddy@linux.ibm.com, linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev" <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Thu, 28 Jul 2022 22:07:46 +0530, Athira Rajeev wrote:
> commit 6320e693d98c ("powerpc/perf: Add support for caps
> under sysfs in powerpc") added support for caps under sysfs
> in powerpc. This added caps directory to:
> /sys/bus/event_source/devices/cpu/ for power8, power9, power10
> and generic compat PMU in respective PMU driver code.
> 
> For power10, it is added under "power10_pmu_attr_groups". But
> for DD1 version, attr_groups are defined under dd1 array:
> "power10_pmu_attr_groups_dd1". Since caps is not added for DD1,
> it fails to include "cpu/caps" in DD1 model. Also issue was
> observed while booting power10 pseries with qemu version6,
> where as not observed with qemu version7. This could be because
> of support for the model in old qemu version. Below is the
> trace log:
> 
> [...]

Applied to powerpc/next.

[1/1] powerpc/perf: Include caps feature for power10 DD1 version
      https://git.kernel.org/powerpc/c/8c9f37a78f70fad763f0d61f03245bb011765086

cheers
