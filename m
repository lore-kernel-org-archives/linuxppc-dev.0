Return-Path: <agraf@suse.de>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 (using TLSv1 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 1D7EF1A023F
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  5 Jun 2014 22:54:52 +1000 (EST)
Message-ID: <53906897.4080209@suse.de>
Date: Thu, 05 Jun 2014 14:54:47 +0200
From: Alexander Graf <agraf@suse.de>
MIME-Version: 1.0
To: Gavin Shan <gwshan@linux.vnet.ibm.com>, kvm-ppc@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v8 0/3] EEH Support for VFIO PCI Device
References: <1401950169-30206-1-git-send-email-gwshan@linux.vnet.ibm.com>
In-Reply-To: <1401950169-30206-1-git-send-email-gwshan@linux.vnet.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: aik@ozlabs.ru, alex.williamson@redhat.com, qiudayu@linux.vnet.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On 05.06.14 08:36, Gavin Shan wrote:
> The series of patches adds support EEH for PCI devices, which are passed
> through to PowerKVM based guest via VFIO. The implementation is straightforward
> based on the issues or problems we have to resolve to support EEH for PowerKVM
> based guest.
>
> - Emulation for EEH RTAS requests. All EEH RTAS requests goes to QEMU firstly.
>    If QEMU can't handle it, the request will be sent to host via newly introduced
>    VFIO container IOCTL command (VFIO_EEH_OP) and gets handled in host kernel.
>
> The series of patches requires corresponding QEMU changes.

Acked-by: Alexander Graf <agraf@suse.de>


Alex
