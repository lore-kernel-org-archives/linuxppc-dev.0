Return-Path: <hare@suse.de>
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 (using TLSv1 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3svpXh3t6RzDt44
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 13 Oct 2016 22:34:12 +1100 (AEDT)
Subject: Re: [PATCH v2 05/16] scsi: fc: provide fc_bsg_to_shost() helper
To: Johannes Thumshirn <jthumshirn@suse.de>,
 "Martin K . Petersen" <martin.petersen@oracle.com>
References: <cover.1476276823.git.jthumshirn@suse.de>
 <a31deec303ab470b574f086e72d3bf0e9f557c65.1476276823.git.jthumshirn@suse.de>
Cc: Christoph Hellwig <hch@infradead.org>,
 Linux Kernel Mailinglist <linux-kernel@vger.kernel.org>,
 Linux SCSI Mailinglist <linux-scsi@vger.kernel.org>,
 Steffen Maier <maier@linux.vnet.ibm.com>,
 Martin Schwidefsky <schwidefsky@de.ibm.com>,
 Heiko Carstens <heiko.carstens@de.ibm.com>,
 Anil Gurumurthy <anil.gurumurthy@qlogic.com>,
 Sudarsana Kalluru <sudarsana.kalluru@qlogic.com>,
 "James E.J. Bottomley" <jejb@linux.vnet.ibm.com>,
 Tyrel Datwyler <tyreld@linux.vnet.ibm.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 Johannes Thumshirn <jth@kernel.org>, James Smart
 <james.smart@avagotech.com>, Dick Kennedy <dick.kennedy@avagotech.com>,
 "supporter:QLOGIC QLA2XXX FC-SCSI DRIVER" <qla2xxx-upstream@qlogic.com>,
 "open list:S390 ZFCP DRIVER" <linux-s390@vger.kernel.org>,
 "open list:LINUX FOR POWERPC (32-BIT AND 64-BIT)"
 <linuxppc-dev@lists.ozlabs.org>,
 "open list:FCOE SUBSYSTEM (libfc, libfcoe, fcoe)" <fcoe-devel@open-fcoe.org>
From: Hannes Reinecke <hare@suse.de>
Message-ID: <527d3750-40da-6e5e-1863-baf9b399cd5d@suse.de>
Date: Thu, 13 Oct 2016 13:34:08 +0200
MIME-Version: 1.0
In-Reply-To: <a31deec303ab470b574f086e72d3bf0e9f557c65.1476276823.git.jthumshirn@suse.de>
Content-Type: text/plain; charset=windows-1252
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 10/12/2016 03:06 PM, Johannes Thumshirn wrote:
> Provide fc_bsg_to_shost() helper that will become handy when we're moving from
> struct fc_bsg_job to a plain struct bsg_job. Also use this little helper in
> the LLDDs.
> 
> Signed-off-by: Johannes Thumshirn <jthumshirn@suse.de>
> ---
>  drivers/s390/scsi/zfcp_fc.c      |  4 +--
>  drivers/scsi/bfa/bfad_bsg.c      |  6 ++---
>  drivers/scsi/ibmvscsi/ibmvfc.c   |  4 +--
>  drivers/scsi/libfc/fc_lport.c    |  2 +-
>  drivers/scsi/lpfc/lpfc_bsg.c     | 32 ++++++++++++------------
>  drivers/scsi/qla2xxx/qla_bsg.c   | 54 ++++++++++++++++++++--------------------
>  drivers/scsi/scsi_transport_fc.c |  2 +-
>  include/scsi/scsi_transport_fc.h |  5 ++++
>  8 files changed, 56 insertions(+), 53 deletions(-)
> 
Reviewed-by: Hannes Reinecke <hare@suse.com>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke		   Teamlead Storage & Networking
hare@suse.de			               +49 911 74053 688
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 Nürnberg
GF: F. Imendörffer, J. Smithard, J. Guild, D. Upmanyu, G. Norton
HRB 21284 (AG Nürnberg)
