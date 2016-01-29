Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 9CD651A0E27
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 29 Jan 2016 12:58:40 +1100 (AEDT)
In-Reply-To: <1453392931-20707-1-git-send-email-hegdevasant@linux.vnet.ibm.com>
To: Vasant Hegde <hegdevasant@linux.vnet.ibm.com>,
 linuxppc-dev@lists.ozlabs.org
From: Michael Ellerman <mpe@ellerman.id.au>
Cc: Vasant Hegde <hegdevasant@linux.vnet.ibm.com>,
 Nathan Fontenot <nfont@linux.vnet.ibm.com>,
 Dan Williams <dan.j.williams@intel.com>
Subject: Re: powerpc/mm: Allow user space to map rtas_rmo_buf
Message-Id: <20160129015840.7EADC1402AC@ozlabs.org>
Date: Fri, 29 Jan 2016 12:58:40 +1100 (AEDT)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2016-21-01 at 16:15:31 UTC, Vasant Hegde wrote:
> With commit 90a545e9 (restrict /dev/mem to idle io memory ranges) mapping
> rtas_rmo_buf from user space is failing. Hence we are not able to make
> RTAS syscall.
> 
> This patch calls page_is_rtas_user_buf before calling iomem_is_exclusive
> in  devmem_is_allowed(). This will allow user space to map rtas_rmo_buf
> and we are able to make RTAS syscall.
> 
> Reported-by: Bharata B Rao <bharata@linux.vnet.ibm.com>
> CC: Dan Williams <dan.j.williams@intel.com>
> CC: Nathan Fontenot <nfont@linux.vnet.ibm.com>
> CC: Michael Ellerman <mpe@ellerman.id.au>
> Signed-off-by: Vasant Hegde <hegdevasant@linux.vnet.ibm.com>
> Acked-by: Dan Williams <dan.j.williams@intel.com>

Applied to powerpc fixes, thanks.

https://git.kernel.org/powerpc/c/e256caa7d0515e301f8c8c6e7d

cheers
