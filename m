Return-Path: <timur@freescale.com>
Received: from de01egw01.freescale.net (de01egw01.freescale.net
	[192.88.165.102]) by ozlabs.org (Postfix) with ESMTP id C2C90DDEAB
	for <linuxppc-dev@ozlabs.org>; Fri, 16 Feb 2007 07:34:29 +1100 (EST)
Message-ID: <45D4C3CF.9080800@freescale.com>
Date: Thu, 15 Feb 2007 14:34:23 -0600
From: Timur Tabi <timur@freescale.com>
MIME-Version: 1.0
To: Sylvain Munaut <tnt@246tNt.com>
Subject: Re: Why do the rh_alloc functions return a pointer?
References: <45D4B486.7030409@freescale.com> <45D4C2CB.2080703@246tNt.com>
In-Reply-To: <45D4C2CB.2080703@246tNt.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Sylvain Munaut wrote:

> I talked about it with Panto on IRC a few days ago.
> 
> And he agrees that the function could be changed to user "unsigned long"
> instead of "void *".

Well, if there is a consensus that this should be changed, then I'll make the patch.

However, since the function prototype for all architectures is in 
include/asm-ppc/rheap.h, I'll need to change powerpc and ppc in the same patch, 
otherwise one of the two will break.

-- 
Timur Tabi
Linux Kernel Developer @ Freescale
