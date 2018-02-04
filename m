Return-Path: <srs0=tlxh=e6=kroah.com=greg@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zZ7yG29VLzDqqZ
 for <linuxppc-dev@lists.ozlabs.org>; Sun,  4 Feb 2018 22:38:14 +1100 (AEDT)
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 by bilbo.ozlabs.org (Postfix) with ESMTP id 3zZ7yF3SGFz8wGh
 for <linuxppc-dev@lists.ozlabs.org>; Sun,  4 Feb 2018 22:38:13 +1100 (AEDT)
Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com
 [66.111.4.28])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3zZ7yD62jJz9t3p
 for <linuxppc-dev@ozlabs.org>; Sun,  4 Feb 2018 22:38:11 +1100 (AEDT)
Date: Sun, 4 Feb 2018 12:06:24 +0100
From: Greg KH <greg@kroah.com>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: stable@vger.kernel.org, linuxppc-dev@ozlabs.org
Subject: Re: [PATCH v4.4 backport 15/16] powerpc/64s: Wire up
 cpu_show_meltdown()
Message-ID: <20180204110624.GJ7519@kroah.com>
References: <20180204050010.13669-1-mpe@ellerman.id.au>
 <20180204050010.13669-16-mpe@ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180204050010.13669-16-mpe@ellerman.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sun, Feb 04, 2018 at 04:00:09PM +1100, Michael Ellerman wrote:
> commit fd6e440f20b1a4304553775fc55938848ff617c9 upstream.
> 
> The recent commit 87590ce6e373 ("sysfs/cpu: Add vulnerability folder")
> added a generic folder and set of files for reporting information on
> CPU vulnerabilities. One of those was for meltdown:
> 
>   /sys/devices/system/cpu/vulnerabilities/meltdown
> 
> This commit wires up that file for 64-bit Book3S powerpc.
> 
> For now we default to "Vulnerable" unless the RFI flush is enabled.
> That may not actually be true on all hardware, further patches will
> refine the reporting based on the CPU/platform etc. But for now we
> default to being pessimists.
> 
> Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>

Also applied to 4.9.y and 4.14.y, thanks.

greg k-h
