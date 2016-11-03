Return-Path: <BATV+eb583682411e33169582+4820+infradead.org+hch@bombadil.srs.infradead.org>
Received: from bombadil.infradead.org (bombadil.infradead.org
 [IPv6:2001:1868:205::9])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3t8pVN3w5mzDvNq
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  4 Nov 2016 02:17:16 +1100 (AEDT)
Date: Thu, 3 Nov 2016 08:17:01 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Johannes Thumshirn <jthumshirn@suse.de>
Cc: "Martin K . Petersen" <martin.petersen@oracle.com>,
 Christoph Hellwig <hch@infradead.org>, Hannes Reinecke <hare@suse.de>,
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
 Johannes Thumshirn <jth@kernel.org>,
 James Smart <james.smart@avagotech.com>,
 Dick Kennedy <dick.kennedy@avagotech.com>,
 "supporter:QLOGIC QLA2XXX FC-SCSI DRIVER" <qla2xxx-upstream@qlogic.com>,
 "open list:S390 ZFCP DRIVER" <linux-s390@vger.kernel.org>,
 "open list:LINUX FOR POWERPC (32-BIT AND 64-BIT)"
 <linuxppc-dev@lists.ozlabs.org>,
 "open list:FCOE SUBSYSTEM (libfc, libfcoe, fcoe)" <fcoe-devel@open-fcoe.org>
Subject: Re: [PATCH v3 03/16] scsi: fc: Export fc_bsg_jobdone and use it in
 FC drivers
Message-ID: <20161103151701.GB7404@infradead.org>
References: <cover.1476369687.git.jthumshirn@suse.de>
 <b7afadab74451838c0b29cc857a7d47174f68c39.1476369687.git.jthumshirn@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <b7afadab74451838c0b29cc857a7d47174f68c39.1476369687.git.jthumshirn@suse.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Oct 13, 2016 at 05:00:19PM +0200, Johannes Thumshirn wrote:
> Export fc_bsg_jobdone so drivers can use it directly instead of doing
> the round-trip via struct fc_bsg_job::job_done() and use it in the LLDDs.
> 
> As we've converted all LLDDs over to use fc_bsg_jobdone() directly,
> we can remove the function pointer from struct fc_bsg_job as well.
> 
> Signed-off-by: Johannes Thumshirn <jthumshirn@suse.de>
> Reviewed-by: Hannes Reinecke <hare@suse.com>

Looks fine,

Reviewed-by: Christoph Hellwig <hch@lst.de>
