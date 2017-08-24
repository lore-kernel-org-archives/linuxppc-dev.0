Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xdP2T2G8vzDrKG
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 24 Aug 2017 22:37:37 +1000 (AEST)
In-Reply-To: <1503467233-12708-1-git-send-email-mpe@ellerman.id.au>
To: Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@ozlabs.org
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Subject: Re: powerpc/vio: Use device_type to detect family
Message-Id: <3xdP2S5mQBz9s8J@ozlabs.org>
Date: Thu, 24 Aug 2017 22:37:36 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2017-08-23 at 05:47:13 UTC, Michael Ellerman wrote:
> Currently in the vio.c code we use a comparision against the parent
> device node's full path to decide if the device is a PFO or VIO family
> device.
> 
> Both the ibm,platform-facilities and vdevice nodes are defined by PAPR,
> and must have a matching device_type. So instead of using the path we
> can instead compare the device_type.
> 
> I've checked Qemu and kvmtool both do this correctly, and all the
> PowerVM systems I have access to do also. So it seems to be safe.
> 
> This removes the dependency on full_name, which is being removed
> upstream.
> 
> Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>

Applied to powerpc next.

https://git.kernel.org/powerpc/c/bcf21e3a97a1247178338793df9ae3

cheers
