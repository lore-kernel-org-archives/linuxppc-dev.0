Return-Path: <tyreld@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3t8zg21YzCzDvnC
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  4 Nov 2016 09:10:21 +1100 (AEDT)
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
 uA3M93E5093482
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 3 Nov 2016 18:10:19 -0400
Received: from e36.co.us.ibm.com (e36.co.us.ibm.com [32.97.110.154])
 by mx0b-001b2d01.pphosted.com with ESMTP id 26edscnn1s-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 03 Nov 2016 18:10:19 -0400
Received: from localhost
 by e36.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <tyreld@linux.vnet.ibm.com>;
 Thu, 3 Nov 2016 16:10:18 -0600
Subject: Re: [PATCH v3 10/16] scsi: change FC drivers to use 'struct bsg_job'
To: Johannes Thumshirn <jthumshirn@suse.de>,
 "Martin K . Petersen" <martin.petersen@oracle.com>
References: <cover.1476369687.git.jthumshirn@suse.de>
 <3704bc7c3933d97357e1c21b84da990b15321c6d.1476369687.git.jthumshirn@suse.de>
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>,
 Paul Mackerras <paulus@samba.org>,
 "open list:S390 ZFCP DRIVER" <linux-s390@vger.kernel.org>,
 Dick Kennedy <dick.kennedy@avagotech.com>,
 "James E.J. Bottomley" <jejb@linux.vnet.ibm.com>,
 Sudarsana Kalluru <sudarsana.kalluru@qlogic.com>,
 Christoph Hellwig <hch@infradead.org>,
 "open list:FCOE SUBSYSTEM libfc, libfcoe, fcoe" <fcoe-devel@open-fcoe.org>,
 Steffen Maier <maier@linux.vnet.ibm.com>, Hannes Reinecke <hare@suse.de>,
 "supporter:QLOGIC QLA2XXX FC-SCSI DRIVER" <qla2xxx-upstream@qlogic.com>,
 Linux SCSI Mailinglist <linux-scsi@vger.kernel.org>,
 Anil Gurumurthy <anil.gurumurthy@qlogic.com>,
 Linux Kernel Mailinglist <linux-kernel@vger.kernel.org>,
 James Smart <james.smart@avagotech.com>,
 Martin Schwidefsky <schwidefsky@de.ibm.com>,
 Johannes Thumshirn <jth@kernel.org>,
 "open list:LINUX FOR POWERPC 32-BIT AND 64-BIT"
 <linuxppc-dev@lists.ozlabs.org>
From: Tyrel Datwyler <tyreld@linux.vnet.ibm.com>
Date: Thu, 3 Nov 2016 15:10:09 -0700
MIME-Version: 1.0
In-Reply-To: <3704bc7c3933d97357e1c21b84da990b15321c6d.1476369687.git.jthumshirn@suse.de>
Content-Type: text/plain; charset=windows-1252
Message-Id: <664a8549-f7d8-f648-0cdc-b54ab1299f13@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 10/13/2016 08:00 AM, Johannes Thumshirn wrote:
> Change FC drivers to use 'struct bsg_job' from bsg-lib.h instead of 'struct
> fc_bsg_job' from scsi_transport_fc.h and remove 'struct fc_bsg_job'.
> 
> Signed-off-by: Johannes Thumshirn <jthumshirn@suse.de>
> Reviewed-by: Hannes Reinecke <hare@suse.com>

For ibmvfc parts,

Acked-by: Tyrel Datwyler <tyreld@linux.vnet.ibm.com>
