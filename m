Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zvzsj0LCDzF0R7
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  5 Mar 2018 23:36:09 +1100 (AEDT)
In-Reply-To: <20180222041739.27899-2-alastair@au1.ibm.com>
To: "Alastair D'Silva" <alastair@au1.ibm.com>, linuxppc-dev@ozlabs.org,
 linux-kernel@vger.kernel.org
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: alastair@au1.ibm.com, arnd@arndb.de, frederic.barrat@fr.ibm.com,
 gregkh@linuxfoundation.org, andrew.donnellan@au1.ibm.com,
 Alastair D'Silva <alastair@d-silva.org>
Subject: Re: [v3,
 1/2] ocxl: Add get_metadata IOCTL to share OCXL information to
 userspace
Message-Id: <3zvzsh56JRz9sZd@ozlabs.org>
Date: Mon,  5 Mar 2018 23:36:08 +1100 (AEDT)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2018-02-22 at 04:17:38 UTC, "Alastair D'Silva" wrote:
> From: Alastair D'Silva <alastair@d-silva.org>
> 
> Some required information is not exposed to userspace currently (eg. the
> PASID), pass this information back, along with other information which
> is currently communicated via sysfs, which saves some parsing effort in
> userspace.
> 
> Signed-off-by: Alastair D'Silva <alastair@d-silva.org>
> Acked-by: Andrew Donnellan <andrew.donnellan@au1.ibm.com>
> Acked-by: Frederic Barrat <fbarrat@linux.vnet.ibm.com>

Series applied to powerpc fixes, thanks.

https://git.kernel.org/powerpc/c/07c5ccd70ad702e561fcda8e4df494

cheers
