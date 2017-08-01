Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xM6GF1hwzzDqhm
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  1 Aug 2017 16:43:17 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Brian King <brking@linux.vnet.ibm.com>
Cc: Frederic Barrat <fbarrat@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org,
 mikey@neuling.org, benh@kernel.crashing.org, clsoto@linux.vnet.ibm.com
Subject: Re: [PATCH v3] powerpc/powernv: Enable PCI peer-to-peer
In-Reply-To: <28e653f1-77cc-f0f4-2355-d2ec582c338f@linux.vnet.ibm.com>
References: <20170717235048.11974-1-fbarrat@linux.vnet.ibm.com>
 <28e653f1-77cc-f0f4-2355-d2ec582c338f@linux.vnet.ibm.com>
Date: Tue, 01 Aug 2017 16:43:16 +1000
Message-ID: <87fudbu6t7.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Brian King <brking@linux.vnet.ibm.com> writes:

> Michael,
>
> What do we need on this one before we can pull into your -next branch?

This skiboot side to be merged.

cheers
