Return-Path: <ebs@ebshome.net>
Received: from gate.ebshome.net (gate.ebshome.net [208.106.21.240])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client CN "gate.ebshome.net", Issuer "gate.ebshome.net" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 61AFADDE46
	for <linuxppc-dev@ozlabs.org>; Thu, 29 Nov 2007 06:57:20 +1100 (EST)
Date: Wed, 28 Nov 2007 11:50:37 -0800
From: Eugene Surovegin <ebs@ebshome.net>
To: Yuri Tikhonov <yur@emcraft.com>
Subject: Re: [PATCH 0/2] [PPC 4xx] L2-cache synchronization for ppc44x
Message-ID: <20071128195037.GB22325@gate.ebshome.net>
References: <7310408706.20071107014010@emcraft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <7310408706.20071107014010@emcraft.com>
Cc: linuxppc-dev@ozlabs.org, sr@denx.de, dzu@denx.de
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, Nov 07, 2007 at 01:40:10AM +0300, Yuri Tikhonov wrote:
> 
>  Hello all,
> 
>  Here is a patch-set for support L2-cache synchronization routines for
> the ppc44x processors family. I know that the "ppc" branch is for bug-fixing only, thus
> the patch-set is just FYI [though enabled but non-coherent L2-cache may appear as a bug for
> someone who uses one of the boards listed below :)].
> 
> [PATCH 1/2] [PPC 4xx] invalidate_l2cache_range() implementation for ppc44x;
> [PATCH 2/2] [PPC 44x] enable L2-cache for the following ppc44x-based boards: ALPR,
> Katmai, Ocotea, and Taishan.

Why is this all needed?

IIRC ibm440gx_l2c_enable() configures 64G snoop region for L2C.

Did AMCC made non-only-coherent L2C chips recently?

-- 
Eugene
