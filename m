Return-Path: <bsingharora@gmail.com>
Received: from mail-pg0-x242.google.com (mail-pg0-x242.google.com
 [IPv6:2607:f8b0:400e:c05::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vSdQS42wWzDq60
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 22 Feb 2017 11:24:00 +1100 (AEDT)
Received: by mail-pg0-x242.google.com with SMTP id 1so13471955pgz.2
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 21 Feb 2017 16:24:00 -0800 (PST)
From: Balbir Singh <bsingharora@gmail.com>
Date: Wed, 22 Feb 2017 11:23:52 +1100
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Cc: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au,
 linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH] powerpc/mm: Add translation mode information in
 /proc/cpuinfo
Message-ID: <20170222002352.GE10842@balbir.ozlabs.ibm.com>
References: <1487499469-15284-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1487499469-15284-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sun, Feb 19, 2017 at 03:47:49PM +0530, Aneesh Kumar K.V wrote:
> With this we have on powernv and pseries /proc/cpuinfo reporting
> 
> timebase        : 512000000
> platform        : PowerNV
> model           : 8247-22L
> machine         : PowerNV 8247-22L
> firmware        : OPAL
> translation     : Hash
> 
> Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
> ---

Acked-by: Balbir Singh <bsingharora@gmail.com>
