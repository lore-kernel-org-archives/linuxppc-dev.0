Return-Path: <jthumshirn@suse.de>
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 (using TLSv1 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 2E6311A0018
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 17 Feb 2016 19:05:42 +1100 (AEDT)
Date: Wed, 17 Feb 2016 09:05:36 +0100
From: Johannes Thumshirn <jthumshirn@suse.de>
To: "Martin K. Petersen" <martin.petersen@oracle.com>
Cc: James Bottomley <James.Bottomley@HansenPartnership.com>,
 linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, nfont@linux.vnet.ibm.com,
 brking@linux.vnet.ibm.com, manoj@linux.vnet.ibm.com,
 Tyrel Datwyler <tyreld@linux.vnet.ibm.com>
Subject: Re: [PATCH v2 3/7] ibmvscsi: Replace magic values in
 set_adpater_info() with defines
Message-ID: <20160217080536.GJ18134@c203.arch.suse.de>
References: <1455154348-3226-1-git-send-email-tyreld@linux.vnet.ibm.com>
 <1455154348-3226-4-git-send-email-tyreld@linux.vnet.ibm.com>
 <1455295395.2396.22.camel@HansenPartnership.com>
 <56BE0D7D.3050703@linux.vnet.ibm.com>
 <yq1k2m4xclf.fsf@sermon.lab.mkp.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <yq1k2m4xclf.fsf@sermon.lab.mkp.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Feb 16, 2016 at 10:03:24PM -0500, Martin K. Petersen wrote:
> >>>>> "Tyrel" == Tyrel Datwyler <tyreld@linux.vnet.ibm.com> writes:
> 
> >> Is there some reason you didn't carry the review tag over from this:
> >> 
> >> http://mid.gmane.org/20160204084459.GW27969@c203.arch.suse.de
> >> 
> >> ?
> >> 
> >> James
> 
> Tyrel> The patch is slightly changed from v1. A define for AIX os type
> Tyrel> was added as mentioned in the cover letter v2 changes, and I
> Tyrel> moved the defines to the mad_adapter_info_data structure around
> Tyrel> the fields they apply.
> 
> Johannes: Mind checking this out?

I'm sorry I though I already did.

Reviewed-by: Johannes Thumshirn <jthumshirn@suse.de>

> 
> https://patchwork.kernel.org/patch/8276101/
> 
> -- 
> Martin K. Petersen	Oracle Linux Engineering

-- 
Johannes Thumshirn                                          Storage
jthumshirn@suse.de                                +49 911 74053 689
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 Nürnberg
GF: Felix Imendörffer, Jane Smithard, Graham Norton
HRB 21284 (AG Nürnberg)
Key fingerprint = EC38 9CAB C2C4 F25D 8600 D0D0 0393 969D 2D76 0850
