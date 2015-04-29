Return-Path: <aik@ozlabs.ru>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 265111A0BF3
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 29 Apr 2015 13:12:31 +1000 (AEST)
Received: from mail-pd0-f178.google.com (mail-pd0-f178.google.com
 [209.85.192.178])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 974AD14012C
 for <linuxppc-dev@ozlabs.org>; Wed, 29 Apr 2015 13:12:30 +1000 (AEST)
Received: by pdea3 with SMTP id a3so14814755pde.3
 for <linuxppc-dev@ozlabs.org>; Tue, 28 Apr 2015 20:12:29 -0700 (PDT)
Message-ID: <55404C16.5040008@ozlabs.ru>
Date: Wed, 29 Apr 2015 13:12:22 +1000
From: Alexey Kardashevskiy <aik@ozlabs.ru>
MIME-Version: 1.0
To: Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>,
 linuxppc-dev@ozlabs.org, thuth@redhat.com
Subject: Re: [PATCH v2 0/4] PCI: Generic fixes and moving enumeration back
 to QEMU
References: <1430121753-24818-1-git-send-email-nikunj@linux.vnet.ibm.com>
In-Reply-To: <1430121753-24818-1-git-send-email-nikunj@linux.vnet.ibm.com>
Content-Type: text/plain; charset=koi8-r; format=flowed
Cc: david@gibson.dropbear.id.au
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 04/27/2015 06:02 PM, Nikunj A Dadhania wrote:
> patch 1:   Fixes a bug in pci-to-pci bridge while programming the limit
>             registers during probe
> patch 2,3: Support 64-bit address translation and usb devices can have
>        	   64-bit pci memory BARs
> patch 4:   Use QEMU create device tree nodes and program the BARs



I taught my "git send-email" wrapper script to add "kernel/qemu/slof" in 
the subject, otherwise I believe it is hard for busy people to tell quickly 
what patchset is for what, I'd recommend you doing the same, especially 
when you mention "QEMU" in a subject  :)



 >
>
>
> Nikunj A Dadhania (4):
>    pci: program correct bridge limit registers during probe
>    pci: Support 64-bit address translation
>    usb: support 64-bit pci bars
>    pci: Use QEMU created PCI device nodes
>
>   board-qemu/slof/pci-phb.fs      | 44 ++++++++++++++++++++++++++++++++++++++++-
>   slof/fs/devices/pci-class_0c.fs | 10 ++++++++--
>   slof/fs/pci-properties.fs       |  6 +++++-
>   slof/fs/pci-scan.fs             |  6 +++---
>   slof/fs/translate.fs            |  6 ++----
>   5 files changed, 61 insertions(+), 11 deletions(-)
>


-- 
Alexey
