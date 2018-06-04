Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40zxg45535zF0dT
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  5 Jun 2018 00:10:56 +1000 (AEST)
In-Reply-To: <20180511061303.10728-2-alastair@au1.ibm.com>
To: "Alastair D'Silva" <alastair@au1.ibm.com>, linuxppc-dev@lists.ozlabs.org
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: mikey@neuling.org, arnd@arndb.de, linux-doc@vger.kernel.org,
 malat@debian.org, gregkh@linuxfoundation.org, corbet@lwn.net,
 vaibhav@linux.vnet.ibm.com, npiggin@gmail.com, linux-kernel@vger.kernel.org,
 fbarrat@linux.vnet.ibm.com, aneesh.kumar@linux.vnet.ibm.com,
 andrew.donnellan@au1.ibm.com, pombredanne@nexb.com, felix@linux.vnet.ibm.com,
 sukadev@linux.vnet.ibm.com, Alastair D'Silva <alastair@d-silva.org>
Subject: Re: [v5,1/7] powerpc: Add TIDR CPU feature for POWER9
Message-Id: <40zxg24KjVz9s0w@ozlabs.org>
Date: Tue,  5 Jun 2018 00:10:53 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2018-05-11 at 06:12:57 UTC, "Alastair D'Silva" wrote:
> From: Alastair D'Silva <alastair@d-silva.org>
> 
> This patch adds a CPU feature bit to show whether the CPU has
> the TIDR register available, enabling as_notify/wait in userspace.
> 
> Signed-off-by: Alastair D'Silva <alastair@d-silva.org>
> Reviewed-by: Frederic Barrat <fbarrat@linux.vnet.ibm.com>
> Reviewed-by: Andrew Donnellan <andrew.donnellan@au1.ibm.com>

Series applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/819844285ef2b5d15466f5b5062514

cheers
