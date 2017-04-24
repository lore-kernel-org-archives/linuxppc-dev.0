Return-Path: <srs0=pwla=4a=kernel.crashing.org=benh@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wBj3W1HDTzDq5b
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 25 Apr 2017 09:19:35 +1000 (AEST)
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 by bilbo.ozlabs.org (Postfix) with ESMTP id 3wBj3W0kkxz8t6N
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 25 Apr 2017 09:19:35 +1000 (AEST)
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3wBj3V2qJ0z9s8Q
 for <linuxppc-dev@ozlabs.org>; Tue, 25 Apr 2017 09:19:34 +1000 (AEST)
Message-ID: <1493075940.25766.244.camel@kernel.crashing.org>
Subject: Re: [PATCH v4 05/11] VAS: Define helpers for access MMIO regions
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>, michael.neuling@au1.ibm.com,
 stewart@linux.vnet.ibm.com, apopple@au1.ibm.com, hbabu@us.ibm.com,
 oohall@gmail.com, bsingharora@gmail.com, linuxppc-dev@ozlabs.org,
 linux-kernel@vger.kernel.org, aneesh.kumar@linux.vnet.ibm.com
Date: Tue, 25 Apr 2017 09:19:00 +1000
In-Reply-To: <20170424172527.GA15532@us.ibm.com>
References: <1490937224-29149-1-git-send-email-sukadev@linux.vnet.ibm.com>
 <1490937224-29149-6-git-send-email-sukadev@linux.vnet.ibm.com>
 <1493015287.25766.213.camel@kernel.crashing.org>
 <20170424172527.GA15532@us.ibm.com>
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

On Mon, 2017-04-24 at 10:25 -0700, Sukadev Bhattiprolu wrote:
> which maybe due to this :-) Should I change to pgprot_noncached() for
> the MMIO writes?

Just use normal ioremap().

> > requires being mapped cachable. Ask Aneesh for a cleaner way of
> > doing it too while at it.
