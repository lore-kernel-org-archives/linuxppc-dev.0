Return-Path: <stewart@linux.vnet.ibm.com>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 8948F1A072E
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 18 Feb 2015 08:45:17 +1100 (AEDT)
Received: from e32.co.us.ibm.com (e32.co.us.ibm.com [32.97.110.150])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id CA7AC1401AF
 for <linuxppc-dev@ozlabs.org>; Wed, 18 Feb 2015 08:45:16 +1100 (AEDT)
Received: from /spool/local
 by e32.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <stewart@linux.vnet.ibm.com>;
 Tue, 17 Feb 2015 14:45:15 -0700
Received: from b03cxnp07028.gho.boulder.ibm.com
 (b03cxnp07028.gho.boulder.ibm.com [9.17.130.15])
 by d03dlp03.boulder.ibm.com (Postfix) with ESMTP id F131A19D8026
 for <linuxppc-dev@ozlabs.org>; Tue, 17 Feb 2015 14:36:20 -0700 (MST)
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
 by b03cxnp07028.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t1HLhYqR32505892
 for <linuxppc-dev@ozlabs.org>; Tue, 17 Feb 2015 14:43:43 -0700
Received: from d03av02.boulder.ibm.com (localhost [127.0.0.1])
 by d03av02.boulder.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t1HLicZS006444
 for <linuxppc-dev@ozlabs.org>; Tue, 17 Feb 2015 14:44:38 -0700
From: Stewart Smith <stewart@linux.vnet.ibm.com>
To: Gavin Shan <gwshan@linux.vnet.ibm.com>, linuxppc-dev@ozlabs.org
Subject: Re: [PATCH RESEND v2 0/7] powerpc/powernv: Unified PCI slot reset and
 hotplug
In-Reply-To: <1424157203-691-1-git-send-email-gwshan@linux.vnet.ibm.com>
References: <1424157203-691-1-git-send-email-gwshan@linux.vnet.ibm.com>
Date: Wed, 18 Feb 2015 08:44:19 +1100
Message-ID: <m3vbj0gqmk.fsf@oc8180480414.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: bhelgaas@google.com, linux-pci@vger.kernel.org,
 Gavin Shan <gwshan@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Gavin Shan <gwshan@linux.vnet.ibm.com> writes:

> The patchset was built based on patchset "powerpc/powernv: Simplify EEH
> implementation", which can be found from:
>
> https://patchwork.ozlabs.org/patch/439956/
>
> The patchset corresponds to skiboot changes, which manages PCI slots
> in a unified way: OPAL APIs used to do slot reset, power management,
> presence status retrival. The patchset shouldn't be merged before
> the OPAL firmware counterpart is merged:
>
> https://patchwork.ozlabs.org/patch/440463/

But this patchset will work with old OPAL, right? We're not breaking
compatibility with newer kernels (with this patchset) and older
firmware?
