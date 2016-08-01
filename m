Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3s2tP4276kzDqQ9
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  1 Aug 2016 18:51:52 +1000 (AEST)
Message-ID: <1470041496.5978.364.camel@kernel.crashing.org>
Subject: Re: [RFC PATCH v2 10/11] powerpc: Support to replay PMIs
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Nicholas Piggin <npiggin@gmail.com>, Madhavan Srinivasan
 <maddy@linux.vnet.ibm.com>
Cc: mpe@ellerman.id.au, anton@samba.org, paulus@samba.org,
 linuxppc-dev@lists.ozlabs.org
Date: Mon, 01 Aug 2016 18:51:36 +1000
In-Reply-To: <20160801180716.5d0a47de@roar.ozlabs.ibm.com>
References: <1469991989-28409-1-git-send-email-maddy@linux.vnet.ibm.com>
 <1469991989-28409-11-git-send-email-maddy@linux.vnet.ibm.com>
 <20160801180716.5d0a47de@roar.ozlabs.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2016-08-01 at 18:07 +1000, Nicholas Piggin wrote:
> This will replay hardware_interrupt_common in the case we got a PMI
> interrupt but no EE.
> 
> Should we just follow the normal pattern here, return 0xf00 for PMI,
> and replay the same as the other cases?

Agreed.

Cheers,
Ben.
