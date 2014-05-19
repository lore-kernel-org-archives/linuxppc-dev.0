Return-Path: <gwshan@linux.vnet.ibm.com>
Received: from e23smtp09.au.ibm.com (e23smtp09.au.ibm.com [202.81.31.142])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 7439A1A0818
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 20 May 2014 09:57:14 +1000 (EST)
Received: from /spool/local
 by e23smtp09.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <gwshan@linux.vnet.ibm.com>;
 Tue, 20 May 2014 09:57:11 +1000
Received: from d23relay03.au.ibm.com (d23relay03.au.ibm.com [9.190.235.21])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id A69432BB0047
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 20 May 2014 09:57:07 +1000 (EST)
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
 by d23relay03.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s4JNuqW164290942
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 20 May 2014 09:56:52 +1000
Received: from d23av03.au.ibm.com (localhost [127.0.0.1])
 by d23av03.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s4JNv76b015710
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 20 May 2014 09:57:07 +1000
Date: Tue, 20 May 2014 09:57:06 +1000
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: Alexander Graf <agraf@suse.de>
Subject: Re: [PATCH 3/8] drivers/vfio: New IOCTL command VFIO_EEH_INFO
Message-ID: <20140519235706.GA10308@shangw>
References: <1400040722-29608-1-git-send-email-gwshan@linux.vnet.ibm.com>
 <1400040722-29608-4-git-send-email-gwshan@linux.vnet.ibm.com>
 <5379FE4F.6070706@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <5379FE4F.6070706@suse.de>
Cc: aik@ozlabs.ru, Gavin Shan <gwshan@linux.vnet.ibm.com>,
 kvm-ppc@vger.kernel.org, alex.williamson@redhat.com,
 qiudayu@linux.vnet.ibm.com, linuxppc-dev@lists.ozlabs.org
Reply-To: Gavin Shan <gwshan@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, May 19, 2014 at 02:51:27PM +0200, Alexander Graf wrote:
>
>On 14.05.14 06:11, Gavin Shan wrote:
>>The patch adds new IOCTL command VFIO_EEH_INFO to VFIO container
>>to support EEH functionality for PCI devices, which have been
>>passed from host to guest via VFIO.
>>
>>Signed-off-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
>>---
>>  arch/powerpc/platforms/powernv/Makefile   |   1 +
>>  arch/powerpc/platforms/powernv/eeh-vfio.c | 593 ++++++++++++++++++++++++++++++
>>  drivers/vfio/vfio_iommu_spapr_tce.c       |  12 +
>>  include/uapi/linux/vfio.h                 |  57 +++
>
>Documentation/...?
>

Will amend it in next revision. Thanks for reminder.

Thanks,
Gavin
