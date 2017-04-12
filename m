Return-Path: <sfr@canb.auug.org.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3w2kzJ3PLtzDq7c
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 12 Apr 2017 10:18:20 +1000 (AEST)
Date: Wed, 12 Apr 2017 10:18:19 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Oliver O'Halloran <oohall@gmail.com>
Cc: Anton Blanchard <anton@samba.org>, Rashmica Gupta
 <rashmica.g@gmail.com>, linuxppc-dev@lists.ozlabs.org,
 arbab@linux.vnet.ibm.com, linux-nvdimm@lists.01.org
Subject: Re: [PATCH 8/9] powerpc/mm: Wire up hpte_removebolted for powernv
Message-ID: <20170412101819.402451e0@canb.auug.org.au>
In-Reply-To: <20170412085056.4da27f32@kryten>
References: <20170411174233.21902-1-oohall@gmail.com>
 <20170411174233.21902-9-oohall@gmail.com>
 <20170412085056.4da27f32@kryten>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Oliver,

On Wed, 12 Apr 2017 08:50:56 +1000 Anton Blanchard <anton@samba.org> wrote:
>
> > From: Rashmica Gupta <rashmica.g@gmail.com>
> > 
> > Adds support for removing bolted (i.e kernel linear mapping) mappings
> > on powernv. This is needed to support memory hot unplug operations
> > which are required for the teardown of DAX/PMEM devices.
> > 
> > Cc: Rashmica Gupta <rashmica.g@gmail.com>
> > Cc: Anton Blanchard <anton@samba.org>
> > Signed-off-by: Oliver O'Halloran <oohall@gmail.com>
> > ---
> > Could the original author of this add their S-o-b? I pulled it out of
> > Rashmica's memtrace patch, but I remember someone saying Anton wrote
> > it originally.  
> 
> I did.
> 
> Signed-off-by: Anton Blanchard <anton@samba.org>

If you are going to claim that Rashmica authored this patch (and you do
with the From: line above), then you need her Signed-off-by as well.

-- 
Cheers,
Stephen Rothwell
