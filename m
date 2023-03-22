Return-Path: <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2CB1C6FD1F
	for <linuxppc-dev@archiver.kernel.org>; Wed, 22 Mar 2023 12:31:58 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4PhSXF1zgQz3fRb
	for <linuxppc-dev@archiver.kernel.org>; Wed, 22 Mar 2023 23:31:57 +1100 (AEDT)
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4PhSR73Qtsz3f3t
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 22 Mar 2023 23:27:31 +1100 (AEDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4PhSR72JStz4xFR;
	Wed, 22 Mar 2023 23:27:31 +1100 (AEDT)
From: Michael Ellerman <patch-notifications@ellerman.id.au>
To: kvm <kvm@vger.kernel.org>, Timothy Pearson <tpearson@raptorengineering.com>
In-Reply-To: <2000135730.16998523.1678123860135.JavaMail.zimbra@raptorengineeringinc.com>
References: <2000135730.16998523.1678123860135.JavaMail.zimbra@raptorengineeringinc.com>
Subject: Re: [PATCH v2 3/4] powerpc/iommu: Add iommu_ops to report capabilities and
Message-Id: <167948793435.559204.9498535193091997320.b4-ty@ellerman.id.au>
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
Cc: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev" <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Mon, 6 Mar 2023 11:31:00 -0600 (CST), Timothy Pearson wrote:
>  allow blocking domains
> 
> Up until now PPC64 managed to avoid using iommu_ops. The VFIO driver
> uses a SPAPR TCE sub-driver and all iommu_ops uses were kept in
> the Type1 VFIO driver. Recent development added 2 uses of iommu_ops to
> the generic VFIO which broke POWER:
> - a coherency capability check;
> - blocking IOMMU domain - iommu_group_dma_owner_claimed()/...
> 
> [...]

Applied to powerpc/next.

[3/4] powerpc/iommu: Add iommu_ops to report capabilities and
      https://git.kernel.org/powerpc/c/a940904443e432623579245babe63e2486ff327b

cheers
