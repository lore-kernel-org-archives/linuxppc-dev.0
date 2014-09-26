Return-Path: <anton@samba.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id AC6471A01DF
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 26 Sep 2014 13:57:06 +1000 (EST)
Date: Fri, 26 Sep 2014 13:57:03 +1000
From: Anton Blanchard <anton@samba.org>
To: Michael Neuling <mikey@neuling.org>
Subject: Re: [PATCH 01/15] powerpc/cell: Move spu_handle_mm_fault() out of
 cell platform
Message-ID: <20140926135703.3f94a7e1@kryten>
In-Reply-To: <1411028820-29933-2-git-send-email-mikey@neuling.org>
References: <1411028820-29933-1-git-send-email-mikey@neuling.org>
 <1411028820-29933-2-git-send-email-mikey@neuling.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: cbe-oss-dev@lists.ozlabs.org, arnd@arndb.de, greg@kroah.com,
 linux-kernel@vger.kernel.org, imunsie@au.ibm.com, linuxppc-dev@ozlabs.org,
 jk@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

> From: Ian Munsie <imunsie@au1.ibm.com>
> 
> Currently spu_handle_mm_fault() is in the cell platform.
> 
> This code is generically useful for other non-cell co-processors on
> powerpc.
> 
> This patch moves this function out of the cell platform into
> arch/powerpc/mm so that others may use it.
> 
> Signed-off-by: Ian Munsie <imunsie@au1.ibm.com>
> Signed-off-by: Michael Neuling <mikey@neuling.org>

Reviewed-by: Anton Blanchard <anton@samba.org>

Anton
