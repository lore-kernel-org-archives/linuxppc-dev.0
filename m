Return-Path: <jesse.barnes@intel.com>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id C77E3B70C4
	for <linuxppc-dev@lists.ozlabs.org>;
	Sat, 15 Aug 2009 03:05:26 +1000 (EST)
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
	by ozlabs.org (Postfix) with ESMTP id 4A5CCDDD1B
	for <linuxppc-dev@ozlabs.org>; Sat, 15 Aug 2009 03:05:25 +1000 (EST)
Date: Fri, 14 Aug 2009 09:54:38 -0700
From: Jesse Barnes <jesse.barnes@intel.com>
To: Mike Mason <mmlnx@us.ibm.com>
Subject: Re: [PATCH 1/3] Support for PCI Express reset type
Message-ID: <20090814095438.217810c6@jbarnes-g45>
In-Reply-To: <4A721FB1.4040903@us.ibm.com>
References: <4A721FB1.4040903@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>,
	Richard Lary <rlary@us.ibm.com>, linux-pci@vger.kernel.org,
	linasvepstas@gmail.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 30 Jul 2009 15:33:21 -0700
Mike Mason <mmlnx@us.ibm.com> wrote:

> This is the first of three patches that implement a bit field that
> PCI Express device drivers can use to indicate they need a
> fundamental reset during error recovery.
> 
> By default, the EEH framework on powerpc does what's known as a "hot
> reset" during recovery of a PCI Express device.  We've found a case
> where the device needs a "fundamental reset" to recover properly.
> The current PCI error recovery and EEH frameworks do not support this
> distinction.
> 
> The attached patch (courtesy of Richard Lary) adds a bit field to
> pci_dev that indicates whether the device requires a fundamental
> reset during recovery.
> 
> These patches supersede the previously submitted patch that
> implemented a fundamental reset bit field. 
> 
> Please review and let me know of any concerns.
> 
> Signed-off-by: Mike Mason <mmlnx@us.ibm.com>
> Signed-off-by: Richard Lary <rlary@us.ibm.com>

Ok, applied this series to my linux-next branch, it looks pretty
reasonable to me.

For future patches, please cc me, and include the subsystem in the
subject, along with a specific description of the patch, e.g. "PCI: add
PCIe fundamental reset interface", "PCI: document PCIe fundamental
reset", or for arch specific patches, "PCI/powerpc: implement support
for PCIe fundamental reset".

Thanks,
-- 
Jesse Barnes, Intel Open Source Technology Center
