Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yLm9G2BRRzDqlT
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 24 Oct 2017 19:08:02 +1100 (AEDT)
In-Reply-To: <20170920062322.6582-1-vaibhav@linux.vnet.ibm.com>
To: Vaibhav Jain <vaibhav@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org,
 Frederic Barrat <fbarrat@linux.vnet.ibm.com>,
 Christophe Lombard <christophe_lombard@fr.ibm.com>
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: Philippe Bergheaud <philippe.bergheaud@fr.ibm.com>,
 Vaibhav Jain <vaibhav@linux.vnet.ibm.com>,
 Andrew Donnellan <andrew.donnellan@au1.ibm.com>,
 Alastair D'Silva <alastair@au1.ibm.com>
Subject: Re: cxl: Provide debugfs access to PSL_DEBUG/XSL_DEBUG registers
Message-Id: <3yLm9G0RqFz9s83@ozlabs.org>
Date: Tue, 24 Oct 2017 19:08:01 +1100 (AEDT)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2017-09-20 at 06:23:22 UTC, Vaibhav Jain wrote:
> Access to PSL/XSL_DEBUG registers on the adapter provides easy access
> to the debug facilities provided by PSL/XSL. So this patch adds two
> new files (debug, xsl-debug) to the cxl-adapter specific debugfs
> folder located at /sys/kernel/debugfs/cxl/card<n>, which will provide
> direct r/w access to corrosponding debug registers in the adapter
> config-space.
> 
> Signed-off-by: Vaibhav Jain <vaibhav@linux.vnet.ibm.com>
> Acked-by: Andrew Donnellan <andrew.donnellan@au1.ibm.com>
> Acked-by: Frederic Barrat <fbarrat@linux.vnet.ibm.com>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/1cafc629408d1883a00c9f656e3de5

cheers
