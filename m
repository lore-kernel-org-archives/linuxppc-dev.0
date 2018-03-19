Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 404rDJ29QrzF1WH
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 20 Mar 2018 09:22:55 +1100 (AEDT)
In-Reply-To: <1519134536-16485-1-git-send-email-clombard@linux.vnet.ibm.com>
To: Christophe Lombard <clombard@linux.vnet.ibm.com>,
 linuxppc-dev@lists.ozlabs.org, fbarrat@linux.vnet.ibm.com,
 vaibhav@linux.vnet.ibm.com, andrew.donnellan@au1.ibm.com
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Subject: Re: [V6] cxl: Fix timebase synchronization status on P9
Message-Id: <404rDH2vtbz9sVr@ozlabs.org>
Date: Tue, 20 Mar 2018 09:22:54 +1100 (AEDT)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2018-02-20 at 13:48:56 UTC, Christophe Lombard wrote:
> The PSL Timebase register is updated by the PSL to maintain the
> timebase.
> On P9, the Timebase value is only provided by the CAPP as received
> the last time a timebase request was performed.
> The timebase requests are initiated through the adapter configuration or
> application registers.
> The specific sysfs entry "/sys/class/cxl/cardxx/psl_timebase_synced" is
> now dynamically updated according the content of the PSL Timebase
> register.
> 
> Signed-off-by: Christophe Lombard <clombard@linux.vnet.ibm.com>
> Reviewed-by: Vaibhav Jain <vaibhav@linux.vnet.ibm.com>
> Acked-by: Andrew Donnellan <andrew.donnellan@au1.ibm.com>
> Acked-by: Frederic Barrat <fbarrat@linux.vnet.ibm.com>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/c2be663d5307fb9751a562ac664fa7

cheers
