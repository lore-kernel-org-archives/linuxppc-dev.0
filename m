Return-Path: <jthumshirn@suse.de>
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 (using TLSv1 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id E93FC1A002B
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 12 Feb 2016 19:19:35 +1100 (AEDT)
Date: Fri, 12 Feb 2016 09:19:28 +0100
From: Johannes Thumshirn <jthumshirn@suse.de>
To: Tyrel Datwyler <tyreld@linux.vnet.ibm.com>
Cc: james.bottomley@hansenpartnership.com, martin.petersen@oracle.com,
 linux-scsi@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 brking@linux.vnet.ibm.com, nfont@linux.vnet.ibm.com
Subject: Re: [PATCH] ibmvfc: byteswap scsi_id, wwpn, and node_name prior to
 logging
Message-ID: <20160212081928.GO27969@c203.arch.suse.de>
References: <1455229475-3984-1-git-send-email-tyreld@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <1455229475-3984-1-git-send-email-tyreld@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Feb 11, 2016 at 04:24:35PM -0600, Tyrel Datwyler wrote:
> When logging async events the scsi_id, wwpn, and node_name values
> are used directly from the CRQ struct which are of type __be64. This
> can be confusing to someone looking through the log on a LE system.
> Instead byteswap these values to host endian prior to logging.
> 
> Signed-off-by: Tyrel Datwyler <tyreld@linux.vnet.ibm.com>

Reviewed-by: Johannes Thumshirn <jthumshirn@suse.de>

-- 
Johannes Thumshirn                                          Storage
jthumshirn@suse.de                                +49 911 74053 689
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 Nürnberg
GF: Felix Imendörffer, Jane Smithard, Graham Norton
HRB 21284 (AG Nürnberg)
Key fingerprint = EC38 9CAB C2C4 F25D 8600 D0D0 0393 969D 2D76 0850
