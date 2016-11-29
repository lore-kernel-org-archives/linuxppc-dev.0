Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tSW2T1kP6zDw6h
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 29 Nov 2016 15:36:01 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org,
 Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
Subject: Re: [PATCH v3 3/4] powerpc/perf: PowerISA v3.0 raw event format
 encoding
In-Reply-To: <1480296076-28880-4-git-send-email-maddy@linux.vnet.ibm.com>
References: <1480296076-28880-1-git-send-email-maddy@linux.vnet.ibm.com>
 <1480296076-28880-4-git-send-email-maddy@linux.vnet.ibm.com>
Date: Tue, 29 Nov 2016 15:36:00 +1100
Message-ID: <87bmwyrjgv.fsf@concordia.ellerman.id.au>
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

Madhavan Srinivasan <maddy@linux.vnet.ibm.com> writes:

> Patch to update the PowerISA v3.0 raw event encoding format
> information and add support for the same in Power9-pmu.c.

I'm not sure if calling this the "PowerISA v3.0" encoding is right. It's
not actually specified in the ISA anywhere right?

Maybe it should just be the "P9 encoding" ?

Though admittedly that is slightly confusing because P9 DD1 doesn't
implement it.

cheers
