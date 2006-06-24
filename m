Return-Path: <olof@lixom.net>
Received: from mail.lixom.net (lixom.net [66.141.50.11])
	by ozlabs.org (Postfix) with ESMTP id 7492A67B14
	for <linuxppc-dev@ozlabs.org>; Sun, 25 Jun 2006 09:28:35 +1000 (EST)
Date: Sat, 24 Jun 2006 16:23:50 -0700
To: Haren Myneni <haren@us.ibm.com>
Subject: Re: [PATCH] powerpc: kdump: Reserve the existing TCE mappings left by
	the first kernel
Message-ID: <20060624232350.GB11299@pb15.lixom.net>
References: <449B8B9E.2050802@us.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <449B8B9E.2050802@us.ibm.com>
From: Olof Johansson <olof@lixom.net>
Cc: Olof Johansson <olof@lixom.net>, linuxppc-dev@ozlabs.org,
	Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, Jun 22, 2006 at 11:35:10PM -0700, Haren Myneni wrote:
> Paul, Olof,
> 
> tce_union got removed in powerpc.git tree. Hence reposting the patch 
> created against this tree. This patch is implemented based on Olof's 
> suggestion of reserving TCE entries and use only available ones in the 
> kdump boot and tested on P5, P4, JS20 and JS21 machines.
> 
> If you are OK with this patch, please send it to upstream.

Looks good to me. Other platforms can add get_tce pointers later as
needed.

> sending to remote machine). Hence, this patch will make sure that 
> minimum of 2048 entries will be available such that kdump boot could be 
> successful in some cases.

Heh, I was pretty sure 10 was way too little. Good to see a number.

> Signed-off-by: Haren Myneni <haren@us.ibm.com>

Acked-by: Olof Johansson <olof@lixom.net>


-Olof
