Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wcJmw41hpzDq5x
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 30 May 2017 13:21:52 +1000 (AEST)
Message-ID: <1496114494.3354.4.camel@kernel.crashing.org>
Subject: Re: [PATCH 2/3] powerpc/mm: Rename find_linux_pte_or_hugepte
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>, paulus@samba.org,
 mpe@ellerman.id.au, Frederic Barrat <fbarrat@linux.vnet.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org
Date: Tue, 30 May 2017 13:21:34 +1000
In-Reply-To: <87zidvpwcl.fsf@skywalker.in.ibm.com>
References: <1494926782-25700-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <1494926782-25700-2-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <1494933772.21847.48.camel@kernel.crashing.org>
 <87wp9g17tt.fsf@skywalker.in.ibm.com>
 <1494997069.3092.5.camel@kernel.crashing.org>
 <87zidvpwcl.fsf@skywalker.in.ibm.com>
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

On Mon, 2017-05-29 at 20:02 +0530, Aneesh Kumar K.V wrote:
> kvmppc_do_h_enter() when get called in real mode.
> 
> For now i have dropped hard_irq_disabled() and switched these usage to
> __find_linux_pte with explict comment around them stating they are
> called with MSR_EE = 0.

Shouldn't these code path also have soft disabled set ?

Cheers,
Ben.
