Return-Path: <hare@suse.de>
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 (using TLSv1 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3svpWQ6KMRzDsyh
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 13 Oct 2016 22:33:06 +1100 (AEDT)
Subject: Re: [PATCH v2 04/16] scsi: Unify interfaces of fc_bsg_jobdone and
 bsg_job_done
To: Johannes Thumshirn <jthumshirn@suse.de>,
 "Martin K . Petersen" <martin.petersen@oracle.com>
References: <cover.1476276823.git.jthumshirn@suse.de>
 <457c9d87193973d6e203eb43b9853138dbc0eafe.1476276823.git.jthumshirn@suse.de>
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
Message-ID: <84d6c834-0976-83bc-7985-68284d9763b8@suse.de>
Date: Thu, 13 Oct 2016 13:33:02 +0200
MIME-Version: 1.0
In-Reply-To: <457c9d87193973d6e203eb43b9853138dbc0eafe.1476276823.git.jthumshirn@suse.de>
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
> Unify the interfaces of fc_bsg_jobdone and bsg_job_done. This will reduce the
> diff when moving from 'struct fc_bsg_job' to a plain 'struct bsg_job' later
> on.
> 
> Signed-off-by: Johannes Thumshirn <jthumshirn@suse.de>
> ---
>  drivers/s390/scsi/zfcp_fc.c      |  2 +-
>  drivers/scsi/bfa/bfad_bsg.c      |  6 ++--
>  drivers/scsi/ibmvscsi/ibmvfc.c   |  3 +-
>  drivers/scsi/libfc/fc_lport.c    |  6 ++--
>  drivers/scsi/lpfc/lpfc_bsg.c     | 68 +++++++++++++++++++++++++++-------------
>  drivers/scsi/qla2xxx/qla_bsg.c   | 66 +++++++++++++++++++++++++-------------
>  drivers/scsi/scsi_transport_fc.c | 22 +++++++------
>  include/scsi/scsi_transport_fc.h |  3 +-
>  8 files changed, 116 insertions(+), 60 deletions(-)
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
