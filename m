Return-Path: <bsingharora@gmail.com>
Received: from mail-pg0-x242.google.com (mail-pg0-x242.google.com
 [IPv6:2607:f8b0:400e:c05::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vSdFv2v1KzDqHy
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 22 Feb 2017 11:16:35 +1100 (AEDT)
Received: by mail-pg0-x242.google.com with SMTP id s67so10096375pgb.1
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 21 Feb 2017 16:16:35 -0800 (PST)
From: Balbir Singh <bsingharora@gmail.com>
Date: Wed, 22 Feb 2017 11:16:26 +1100
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Cc: Balbir Singh <bsingharora@gmail.com>, benh@kernel.crashing.org,
 paulus@samba.org, mpe@ellerman.id.au, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH V3 01/10] powerpc/mm/slice: Convert slice_mask high slice
 to a bitmap
Message-ID: <20170222001626.GB10842@balbir.ozlabs.ibm.com>
References: <1487498837-12017-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <1487498837-12017-2-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <20170221044300.GA21059@balbir.ozlabs.ibm.com>
 <5735c55a-df11-cfb5-7e61-d467ba3718eb@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <5735c55a-df11-cfb5-7e61-d467ba3718eb@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Feb 21, 2017 at 12:26:15PM +0530, Aneesh Kumar K.V wrote:
> 
> 
> On Tuesday 21 February 2017 10:13 AM, Balbir Singh wrote:
> > On Sun, Feb 19, 2017 at 03:37:08PM +0530, Aneesh Kumar K.V wrote:
> > > In followup patch we want to increase the va range which will result
> > > in us requiring high_slices to have more than 64 bits. To enable this
> > > convert high_slices to bitmap. We keep the number bits same in this patch
> > > and later change that to higher value
> > > 
> > > Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
> > > ---
> > For consistency it would be nice to have low_slices represented similarly
> > as well.
> 
> That will need converting lot of low_slices update to bitmap api with no
> real benefit

Consistency and not having our own bitmap implementation :) Anways,
I am not too held up on it.

> > Acked-by: Balbir Singh <bsingharora@gmail.com>
> > 
> 
> -aneesh
> 
