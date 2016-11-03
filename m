Return-Path: <BATV+eb583682411e33169582+4820+infradead.org+hch@bombadil.srs.infradead.org>
Received: from bombadil.infradead.org (bombadil.infradead.org
 [IPv6:2001:1868:205::9])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3t8pWC2Sv5zDvYc
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  4 Nov 2016 02:17:59 +1100 (AEDT)
Date: Thu, 3 Nov 2016 08:17:33 -0700
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
Subject: Re: [PATCH v3 04/16] scsi: Unify interfaces of fc_bsg_jobdone and
 bsg_job_done
Message-ID: <20161103151733.GC7404@infradead.org>
References: <cover.1476369687.git.jthumshirn@suse.de>
 <2b02bb8460fa27db4fe971a2161e0cb7c2fca4df.1476369687.git.jthumshirn@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <2b02bb8460fa27db4fe971a2161e0cb7c2fca4df.1476369687.git.jthumshirn@suse.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Oct 13, 2016 at 05:00:20PM +0200, Johannes Thumshirn wrote:
> Unify the interfaces of fc_bsg_jobdone and bsg_job_done. This will reduce the
> diff when moving from 'struct fc_bsg_job' to a plain 'struct bsg_job' later
> on.
> 
> Signed-off-by: Johannes Thumshirn <jthumshirn@suse.de>
> Reviewed-by: Hannes Reinecke <hare@suse.com>

Looks fine, although I would have merged it into the previous patch:

Reviewed-by: Christoph Hellwig <hch@lst.de>
