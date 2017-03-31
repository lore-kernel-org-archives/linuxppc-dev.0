Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vvgsZ5bjSzDq7Z
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 31 Mar 2017 23:33:54 +1100 (AEDT)
In-Reply-To: <20170322192751.30531-2-gpiccoli@linux.vnet.ibm.com>
To: "Guilherme G. Piccoli" <gpiccoli@linux.vnet.ibm.com>,
 linuxppc-dev@lists.ozlabs.org
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: xinhui.pan@linux.vnet.ibm.com, paulus@samba.org,
 gpiccoli@linux.vnet.ibm.com
Subject: Re: [v4, 1/3] powerpc/xmon: Fix an unexpected xmon on/off state change
Message-Id: <3vvgsZ3rypz9s77@ozlabs.org>
Date: Fri, 31 Mar 2017 23:33:54 +1100 (AEDT)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2017-03-22 at 19:27:49 UTC, "Guilherme G. Piccoli" wrote:
> From: Pan Xinhui <xinhui.pan@linux.vnet.ibm.com>
> 
> Once xmon is triggered by sysrq-x, it is enabled always afterwards even
> if it is disabled during boot. This will cause a system reset interrupt
> fail to dump. So keep xmon in its original state after exit.
> 
> We have several ways to set xmon on or off.
> 1) by a build config CONFIG_XMON_DEFAULT.
> 2) by a boot cmdline with xmon or xmon=early or xmon=on to enable xmon
> and xmon=off to disable xmon. This value will override that in step 1.
> 3) by a debugfs interface, as proposed in this patchset.
> And this value can override those in step 1 and 2.
> 
> Signed-off-by: Pan Xinhui <xinhui.pan@linux.vnet.ibm.com>
> Signed-off-by: Guilherme G. Piccoli <gpiccoli@linux.vnet.ibm.com>

Series applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/3b5bf42b81d56085fd58692b5117f6

cheers
