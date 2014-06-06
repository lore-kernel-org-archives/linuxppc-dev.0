Return-Path: <gwshan@linux.vnet.ibm.com>
Received: from e23smtp06.au.ibm.com (e23smtp06.au.ibm.com [202.81.31.148])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 7038D1A0242
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  6 Jun 2014 10:56:49 +1000 (EST)
Received: from /spool/local
 by e23smtp06.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <gwshan@linux.vnet.ibm.com>;
 Fri, 6 Jun 2014 10:56:49 +1000
Received: from d23relay04.au.ibm.com (d23relay04.au.ibm.com [9.190.234.120])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id 6DBD72CE8040
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  6 Jun 2014 10:56:47 +1000 (EST)
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
 by d23relay04.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s560emk717498122
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 6 Jun 2014 10:40:48 +1000
Received: from d23av03.au.ibm.com (localhost [127.0.0.1])
 by d23av03.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s560ukZ3001053
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 6 Jun 2014 10:56:46 +1000
Date: Fri, 6 Jun 2014 10:56:46 +1000
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: Alexander Graf <agraf@suse.de>
Subject: Re: [PATCH v8 0/3] EEH Support for VFIO PCI Device
Message-ID: <20140606005646.GA17860@shangw>
References: <1401950169-30206-1-git-send-email-gwshan@linux.vnet.ibm.com>
 <53906897.4080209@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <53906897.4080209@suse.de>
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

On Thu, Jun 05, 2014 at 02:54:47PM +0200, Alexander Graf wrote:
>
>On 05.06.14 08:36, Gavin Shan wrote:
>>The series of patches adds support EEH for PCI devices, which are passed
>>through to PowerKVM based guest via VFIO. The implementation is straightforward
>>based on the issues or problems we have to resolve to support EEH for PowerKVM
>>based guest.
>>
>>- Emulation for EEH RTAS requests. All EEH RTAS requests goes to QEMU firstly.
>>   If QEMU can't handle it, the request will be sent to host via newly introduced
>>   VFIO container IOCTL command (VFIO_EEH_OP) and gets handled in host kernel.
>>
>>The series of patches requires corresponding QEMU changes.
>
>Acked-by: Alexander Graf <agraf@suse.de>
>

Thanks, Alex :)

>
>Alex
>
