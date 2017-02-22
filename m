Return-Path: <bsingharora@gmail.com>
Received: from mail-pg0-x234.google.com (mail-pg0-x234.google.com
 [IPv6:2607:f8b0:400e:c05::234])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vSdL53NZvzDqKK
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 22 Feb 2017 11:20:13 +1100 (AEDT)
Received: by mail-pg0-x234.google.com with SMTP id b129so43376337pgc.2
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 21 Feb 2017 16:20:13 -0800 (PST)
From: Balbir Singh <bsingharora@gmail.com>
Date: Wed, 22 Feb 2017 11:20:05 +1100
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Cc: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au,
 linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH V3 10/10] powerpc/mm/slice: Update slice mask printing to
 use bitmap printing.
Message-ID: <20170222002005.GD10842@balbir.ozlabs.ibm.com>
References: <1487498837-12017-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <1487498837-12017-11-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1487498837-12017-11-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sun, Feb 19, 2017 at 03:37:17PM +0530, Aneesh Kumar K.V wrote:
> We now get output like below which is much better.
> 
> [    0.935306]  good_mask low_slice: 0-15
> [    0.935360]  good_mask high_slice: 0-511
> 
> Compared to
> 
> [    0.953414]  good_mask:1111111111111111 - 1111111111111.........
> 
> I also fixed an error with slice_dbg printing.
> 
> Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
> ---

Yep, like this much better

Acked-by: Balbir Singh <bsingharora@gmail.com>
