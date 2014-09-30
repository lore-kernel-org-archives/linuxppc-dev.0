Return-Path: <arnd@arndb.de>
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.17.24])
 (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 798271A1885
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 30 Sep 2014 20:41:01 +1000 (EST)
From: Arnd Bergmann <arnd@arndb.de>
To: linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v2 03/17] powerpc/cell: Make spu_flush_all_slbs() generic
Date: Tue, 30 Sep 2014 12:40:47 +0200
Message-ID: <2075902.qYMJnrEVUR@wuerfel>
In-Reply-To: <1412073306-13812-4-git-send-email-mikey@neuling.org>
References: <1412073306-13812-1-git-send-email-mikey@neuling.org>
 <1412073306-13812-4-git-send-email-mikey@neuling.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Cc: cbe-oss-dev@lists.ozlabs.org, Michael Neuling <mikey@neuling.org>,
 greg@kroah.com, imunsie@au.ibm.com, linux-kernel@vger.kernel.org,
 linuxppc-dev@ozlabs.org, "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
 anton@samba.org, jk@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tuesday 30 September 2014 20:34:52 Michael Neuling wrote:
> From: Ian Munsie <imunsie@au1.ibm.com>
> 
> This moves spu_flush_all_slbs() into a generic call copro_flush_all_slbs().
> 
> This will be useful when we add cxl which also needs a similar SLB flush call.
> 
> Signed-off-by: Ian Munsie <imunsie@au1.ibm.com>
> Signed-off-by: Michael Neuling <mikey@neuling.org>
> 

Very nice!

Acked-by: Arnd Bergmann <arnd@arndb.de>
