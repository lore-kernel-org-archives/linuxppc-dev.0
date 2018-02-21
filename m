Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zmdwY0G4gzF0xj
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 22 Feb 2018 00:43:08 +1100 (AEDT)
In-Reply-To: <1518720591-84657-1-git-send-email-bryantly@linux.vnet.ibm.com>
To: "Bryant G. Ly" <bryantly@linux.vnet.ibm.com>, benh@kernel.crashing.org,
 paulus@samba.org
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: aik@ozlabs.ru, linuxppc-dev@lists.ozlabs.org, jjalvare@linux.vnet.ibm.com,
 seroyer@linux.vnet.ibm.com
Subject: Re: powerpc/eeh: Add conditional check on notify_resume
Message-Id: <3zmdwW53n5z9sX8@ozlabs.org>
Date: Thu, 22 Feb 2018 00:43:06 +1100 (AEDT)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2018-02-15 at 18:49:51 UTC, "Bryant G. Ly" wrote:
> From: "Juan J. Alvarez" <jjalvare@linux.vnet.ibm.com>
> 
> EEH structure is not populated with function
> notify resume when running on systems that do not support
> it, i.e: BMC. Hence adding a conditional check for NULL for
> systems that don't add function notify_resume.
> 
> Signed-off-by: Juan J. Alvarez <jjalvare@linux.vnet.ibm.com>
> Reviewed-by: Bryant G. Ly <bryantly@linux.vnet.ibm.com>
> Tested-by: Carol L. Soto <clsoto@us.ibm.com>
> Reviewed-by: Andrew Donnellan <andrew.donnellan@au1.ibm.com>
> Tested-by: Mauro S. M. Rodrigues <maurosr@linux.vnet.ibm.com>
> Acked-by: Michael Neuling <mikey@neuling.org>

Applied to powerpc fixes, thanks.

https://git.kernel.org/powerpc/c/521ca5a9859a870e354d1a6b84a6ff

cheers
