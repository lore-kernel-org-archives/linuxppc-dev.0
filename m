Return-Path: <hare@suse.com>
Received: from smtp.nue.novell.com (smtp.nue.novell.com [195.135.221.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wyqHY1gbGzDr4N
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 29 Jun 2017 16:19:04 +1000 (AEST)
Subject: Re: [PATCH 3/3] cxlflash: Update debug prints in reset handlers
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
 <1498670077-39845-1-git-send-email-mrochs@linux.vnet.ibm.com>
From: Hannes Reinecke <hare@suse.com>
Message-ID: <bd2f0bf6-b63a-ad7d-89fc-e6fbe19a2494@suse.com>
Date: Thu, 29 Jun 2017 07:58:56 +0200
MIME-Version: 1.0
In-Reply-To: <1498670077-39845-1-git-send-email-mrochs@linux.vnet.ibm.com>
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
> The device and host reset handler contain debug prints to help
> identify the entities being reset. Today these reset handlers
> are based on a SCSI EH design that uses a SCSI command reference
> as a means of identifying the target entity. As such, the debug
> trace includes the SCSI command pointer and associated CDB. This
> is not necessary as the SCSI command is simply the messenger in
> these scenarios.
> 
> Refactor the debug prints in the host and reset handlers to only
> present information that is applicable given the function scope.
> 
> Signed-off-by: Matthew R. Ochs <mrochs@linux.vnet.ibm.com>
> ---
>  drivers/scsi/cxlflash/main.c | 18 +++---------------
>  1 file changed, 3 insertions(+), 15 deletions(-)
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
