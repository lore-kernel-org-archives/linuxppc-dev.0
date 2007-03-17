Return-Path: <yur@emcraft.com>
Received: from ocean.emcraft.com (ocean.emcraft.com [213.221.7.182])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 6C819DDECA
	for <linuxppc-dev@ozlabs.org>; Sat, 17 Mar 2007 22:37:52 +1100 (EST)
From: Yuri Tikhonov <yur@emcraft.com>
To: Paul Mackerras <paulus@samba.org>,
 linuxppc-dev@ozlabs.org
Subject: Re: [PATCH] ppc: Add support for bigger page sizes than 4KB on PPC44x
Date: Sat, 17 Mar 2007 14:41:51 +0300
References: <200703161634.58444.yur@emcraft.com>
	<17915.7048.393811.714143@cargo.ozlabs.ibm.com>
In-Reply-To: <17915.7048.393811.714143@cargo.ozlabs.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200703171441.51276.yur@emcraft.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Saturday 17 March 2007 01:34, Paul Mackerras wrote:
> Your patch would still let users select a page shift of 13 or 15,
> which won't work (and can't be made to work).

 Selecting 13 or 15 will lead to a compile-time error "Unsupported PAGE_SIZE" 
(in include/asm/ppc_page_asm.h), so users will not be able to run kernel with 
PAGE_SIZE different than 4K, 16K or 64K anyway. 

 Do you think that replacing one integer option CONFIG_PPC_PAGE_SHIFT with 
three logical options (i.e., CONFIG_PPC_PAGE_SIZE_4K, 
CONFIG_PPC_PAGE_SIZE_16K and CONFIG_PPC_PAGE_SIZE_64K) will be the better 
choice ?

 Regards, Yuri.
