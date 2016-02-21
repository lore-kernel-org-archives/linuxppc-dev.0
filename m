Return-Path: <manoj@linux.vnet.ibm.com>
Received: from e36.co.us.ibm.com (e36.co.us.ibm.com [32.97.110.154])
 (using TLSv1.2 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id AE5B81A0353
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 22 Feb 2016 10:22:06 +1100 (AEDT)
Received: from localhost
 by e36.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <manoj@linux.vnet.ibm.com>;
 Sun, 21 Feb 2016 16:22:04 -0700
Received: from b03cxnp08025.gho.boulder.ibm.com
 (b03cxnp08025.gho.boulder.ibm.com [9.17.130.17])
 by d03dlp02.boulder.ibm.com (Postfix) with ESMTP id 835873E4003F
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 21 Feb 2016 16:21:56 -0700 (MST)
Received: from d03av01.boulder.ibm.com (d03av01.boulder.ibm.com [9.17.195.167])
 by b03cxnp08025.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u1LNLu0V35848356
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 21 Feb 2016 16:21:56 -0700
Received: from d03av01.boulder.ibm.com (localhost [127.0.0.1])
 by d03av01.boulder.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u1LNLtVb023342
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 21 Feb 2016 16:21:56 -0700
Reply-To: manoj@linux.vnet.ibm.com
Subject: Re: Fwd: [PATCH v4 10/18] cxl: New hcalls to support CAPI adapters
References: <1455658751-16970-11-git-send-email-fbarrat@linux.vnet.ibm.com>
 <56CA2CC6.9010802@linux.vnet.ibm.com>
To: fbarrat@linux.vnet.ibm.com
Cc: Ian Munsie <imunsie@au1.ibm.com>, michael.neuling@au1.ibm.com,
 mpe@ellerman.id.au, linuxppc-dev@lists.ozlabs.org
From: Manoj Kumar <manoj@linux.vnet.ibm.com>
Message-ID: <56CA46A6.3070005@linux.vnet.ibm.com>
Date: Sun, 21 Feb 2016 17:22:14 -0600
MIME-Version: 1.0
In-Reply-To: <56CA2CC6.9010802@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Fred: See comments below.

The most egregious checkpatch violations so far in this series,
for going beyond 80 columns.

total: 65 warnings, 924 lines checked


On 2/21/2016 3:31 PM, Uma Krishnan wrote:
> From: Christophe Lombard <clombard@linux.vnet.ibm.com>
>
> The hypervisor calls provide an interface with a coherent plaform

plaform->platform


> +/**
> + * cxl_h_download_adapter_image - Download the base image in the coherent
> + *                                platoform facility.


platoform->platform

> +
> +/**
> + * cxl_h_validate_adapter_image - Validate the base image in the coherent
> + *                                platoform facility.

platoform->platform

Irreverent to the Socratic amongst us.
