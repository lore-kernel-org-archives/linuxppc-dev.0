Return-Path: <tyreld@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3t8zdN5hvZzDvM6
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  4 Nov 2016 09:08:56 +1100 (AEDT)
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
 uA3M3tPB005832
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 3 Nov 2016 18:08:55 -0400
Received: from e31.co.us.ibm.com (e31.co.us.ibm.com [32.97.110.149])
 by mx0a-001b2d01.pphosted.com with ESMTP id 26g9v6wkdm-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 03 Nov 2016 18:08:54 -0400
Received: from localhost
 by e31.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <tyreld@linux.vnet.ibm.com>;
 Thu, 3 Nov 2016 16:08:54 -0600
Subject: Re: [PATCH v3 06/16] scsi: fc: provide fc_bsg_to_rport() helper
To: Johannes Thumshirn <jthumshirn@suse.de>,
 "Martin K . Petersen" <martin.petersen@oracle.com>
References: <cover.1476369687.git.jthumshirn@suse.de>
 <9b2273fd57def066d9c8b5b45a2ee43752a67cc9.1476369687.git.jthumshirn@suse.de>
Cc: "open list:S390 ZFCP DRIVER" <linux-s390@vger.kernel.org>,
 Dick Kennedy <dick.kennedy@avagotech.com>,
 "James E.J. Bottomley" <jejb@linux.vnet.ibm.com>,
 Linux SCSI Mailinglist <linux-scsi@vger.kernel.org>,
 "supporter:QLOGIC QLA2XXX FC-SCSI DRIVER" <qla2xxx-upstream@qlogic.com>,
 Heiko Carstens <heiko.carstens@de.ibm.com>,
 Linux Kernel Mailinglist <linux-kernel@vger.kernel.org>,
 "open list:FCOE SUBSYSTEM libfc, libfcoe, fcoe" <fcoe-devel@open-fcoe.org>,
 Christoph Hellwig <hch@infradead.org>,
 Martin Schwidefsky <schwidefsky@de.ibm.com>,
 James Smart <james.smart@avagotech.com>,
 Paul Mackerras <paulus@samba.org>, Hannes Reinecke <hare@suse.de>,
 Steffen Maier <maier@linux.vnet.ibm.com>,
 Johannes Thumshirn <jth@kernel.org>,
 "open list:LINUX FOR POWERPC 32-BIT AND 64-BIT"
 <linuxppc-dev@lists.ozlabs.org>
From: Tyrel Datwyler <tyreld@linux.vnet.ibm.com>
Date: Thu, 3 Nov 2016 15:08:45 -0700
MIME-Version: 1.0
In-Reply-To: <9b2273fd57def066d9c8b5b45a2ee43752a67cc9.1476369687.git.jthumshirn@suse.de>
Content-Type: text/plain; charset=windows-1252
Message-Id: <eeef81eb-2ffe-6d13-f0a4-c2deb7553eb2@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 10/13/2016 08:00 AM, Johannes Thumshirn wrote:
> Provide fc_bsg_to_rport() helper that will become handy when we're moving
> from struct fc_bsg_job to a plain struct bsg_job. Also move all LLDDs to use
> the new helper.
> 
> Signed-off-by: Johannes Thumshirn <jthumshirn@suse.de>
> Reviewed-by: Hannes Reinecke <hare@suse.com>


For ibmvfc parts,

Acked-by: Tyrel Datwyler <tyreld@linux.vnet.ibm.com>
