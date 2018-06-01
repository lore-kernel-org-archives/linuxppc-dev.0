Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40y86Q4xqKzDrph
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  2 Jun 2018 01:54:54 +1000 (AEST)
In-Reply-To: <20180417051102.7577-1-vaibhav@linux.vnet.ibm.com>
To: Vaibhav Jain <vaibhav@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org,
 Frederic Barrat <fbarrat@linux.vnet.ibm.com>
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: Philippe Bergheaud <philippe.bergheaud@fr.ibm.com>,
 Alastair D'Silva <alastair@linux.ibm.com>,
 Vaibhav Jain <vaibhav@linux.vnet.ibm.com>,
 Andrew Donnellan <andrew.donnellan@au1.ibm.com>,
 Christophe Lombard <christophe_lombard@fr.ibm.com>
Subject: Re: cxl: Configure PSL to not use APC virtual machines
Message-Id: <40y86Q3flXz9s1b@ozlabs.org>
Date: Sat,  2 Jun 2018 01:54:54 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2018-04-17 at 05:11:02 UTC, Vaibhav Jain wrote:
> APC virtual machines arent used on POWER-9 chips and are already
> disabled in on-chip CAPP. They also need to be disabled on the PSL via
> 'PSL Data Send Control Register' by setting bit(47). This forces the
> PSL to send commands to CAPP with queue.id == 0.
> 
> Signed-off-by: Vaibhav Jain <vaibhav@linux.vnet.ibm.com>
> Acked-by: Andrew Donnellan <andrew.donnellan@au1.ibm.com>
> Reviewed-by: Alastair D'Silva <alastair@d-silva.org>
> Reviewed-by: Christophe Lombard <clombard@linux.vnet.ibm.com>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/9a6d2022bacd8fca0be6297459a02d

cheers
