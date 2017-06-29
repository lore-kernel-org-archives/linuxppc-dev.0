Return-Path: <hare@suse.com>
Received: from smtp.nue.novell.com (smtp.nue.novell.com [195.135.221.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wyqHD1lTbzDr4N
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 29 Jun 2017 16:18:47 +1000 (AEST)
Subject: Re: [PATCH 2/3] cxlflash: Update send_tmf() parameters
To: "Matthew R. Ochs" <mrochs@linux.vnet.ibm.com>, linux-scsi@vger.kernel.org,
 James Bottomley <James.Bottomley@HansenPartnership.com>,
 "Martin K. Petersen" <martin.petersen@oracle.com>,
 Uma Krishnan <ukrishn@linux.vnet.ibm.com>,
 "Manoj N. Kumar" <manoj@linux.vnet.ibm.com>
Cc: Frederic Barrat <fbarrat@linux.vnet.ibm.com>,
 Andrew Donnellan <andrew.donnellan@au1.ibm.com>,
 Christophe Lombard <clombard@linux.vnet.ibm.com>,
 linuxppc-dev@lists.ozlabs.org
References: <1498669929-39684-1-git-send-email-mrochs@linux.vnet.ibm.com>
 <1498670070-39805-1-git-send-email-mrochs@linux.vnet.ibm.com>
From: Hannes Reinecke <hare@suse.com>
Message-ID: <9145e63e-ba23-0dee-c3e2-953a735f1543@suse.com>
Date: Thu, 29 Jun 2017 07:58:39 +0200
MIME-Version: 1.0
In-Reply-To: <1498670070-39805-1-git-send-email-mrochs@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 06/28/2017 07:14 PM, Matthew R. Ochs wrote:
> The current send_tmf() implementation is based on the caller providing
> a SCSI command reference. In reality all that is needed is a SCSI device
> reference as the routine uses a private command.
> 
> Refactor send_tmf() to pass the private adapter configuration reference
> and a SCSI device reference. As a nice side effect, this will ease the
> burden of converting caller routines to be based solely off of a SCSI
> device reference.
> 
> Signed-off-by: Matthew R. Ochs <mrochs@linux.vnet.ibm.com>
> ---
>  drivers/scsi/cxlflash/main.c | 27 +++++++++++++--------------
>  1 file changed, 13 insertions(+), 14 deletions(-)
> 
Reviewed-by: Hannes Reinecke <hare@suse.com>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke		               zSeries & Storage
hare@suse.com			               +49 911 74053 688
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 Nürnberg
GF: F. Imendörffer, J. Smithard, D. Upmanyu, G. Norton
HRB 21284 (AG Nürnberg)
