Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vzNJ04DjhzDqKJ
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  6 Apr 2017 23:06:08 +1000 (AEST)
In-Reply-To: <1491213104-24450-3-git-send-email-alistair@popple.id.au>
To: Alistair Popple <alistair@popple.id.au>
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: devicetree@vger.kernel.org, Alistair Popple <alistair@popple.id.au>,
 mhairgrove@nvidia.com, linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org,
 robh+dt@kernel.org, shailendras@nvidia.com
Subject: Re: [v2,
 3/3] powerpc/powernv: Introduce address translation services for
 Nvlink2
Message-Id: <3vzNJ01sS5z9s8N@ozlabs.org>
Date: Thu,  6 Apr 2017 23:06:08 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2017-04-03 at 09:51:44 UTC, Alistair Popple wrote:
> Nvlink2 supports address translation services (ATS) allowing devices
> to request address translations from an mmu known as the nest MMU
> which is setup to walk the CPU page tables.
> 
> To access this functionality certain firmware calls are required to
> setup and manage hardware context tables in the nvlink processing unit
> (NPU). The NPU also manages forwarding of TLB invalidates (known as
> address translation shootdowns/ATSDs) to attached devices.
> 
> This patch exports several methods to allow device drivers to register
> a process id (PASID/PID) in the hardware tables and to receive
> notification of when a device should stop issuing address translation
> requests (ATRs). It also adds a fault handler to allow device drivers
> to demand fault pages in.
> 
> Signed-off-by: Alistair Popple <alistair@popple.id.au>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/1ab66d1fbadad86b1f4a9c7857e193

cheers
