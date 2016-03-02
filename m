Return-Path: <ruscur@russell.cc>
Received: from russell.cc (russell.cc [IPv6:2404:9400:2:0:216:3eff:fee0:3370])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 61D651A0BB5
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  2 Mar 2016 12:04:47 +1100 (AEDT)
Message-ID: <1456880682.4528.5.camel@russell.cc>
Subject: Re: [PATCH 0/3] powerpc/eeh: Enhancement to EEH for VF
From: Russell Currey <ruscur@russell.cc>
To: Gavin Shan <gwshan@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org
Date: Wed, 02 Mar 2016 12:04:42 +1100
In-Reply-To: <1456445092-18337-1-git-send-email-gwshan@linux.vnet.ibm.com>
References: <1456445092-18337-1-git-send-email-gwshan@linux.vnet.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2016-02-26 at 11:04 +1100, Gavin Shan wrote:
> Those patches are based on the series of patches supporting EEH for VF,
> which is pending for merging: https://patchwork.ozlabs.org/patch/581315/
> 
> This series of patches fixes couple of issue that resides in previous
> patchset:
> 
>    * The error handlers provided by vfio-pci driver shouldn't be called.
>      Otherwise, the guest is simply killed.
>    * When we have partially hoplug in error recovery, we shouldn't remove
>      those passed-through devices. Otherwise, the guest will be brought
>      to undefined situation.
>    * When we have errors detected on PF PE, hold VF PE that has been
> passed
>      through to guest until the recovery on PF PE is done
> 
> Gavin Shan (3):
>   powerpc/eeh: Don't propagate error to guest
>   powerpc/eeh: Don't remove passed VFs
>   powerpc/eeh: Synchronize recovery in host/guest
> 
>  arch/powerpc/kernel/eeh.c        | 11 +++++++++++
>  arch/powerpc/kernel/eeh_driver.c | 13 ++++++++-----
>  2 files changed, 19 insertions(+), 5 deletions(-)
> 

For the whole series (incorporating my comments on patch 3):

Reviewed-by: Russell Currey <ruscur@russell.cc>
