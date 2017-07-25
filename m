Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (bilbo.ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xGvzy69Z0zDqm4
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 25 Jul 2017 20:46:22 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Nicholas Piggin <npiggin@gmail.com>,
 Gautham R Shenoy <ego@linux.vnet.ibm.com>
Cc: Michael Neuling <mikey@neuling.org>,
 Vaidyanathan Srinivasan <svaidy@linux.vnet.ibm.com>,
 Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>,
 Akshay Adiga <akshay.adiga@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] powernv/powerpc: Clear PECE1 in LPCR via stop-api
 only on Hotplug
In-Reply-To: <20170719152032.7724085f@roar.ozlabs.ibm.com>
References: <cover.1500361607.git.ego@linux.vnet.ibm.com>
 <a3ba2f2ddfbe0145ca28963b487c14473a396269.1500361607.git.ego@linux.vnet.ibm.com>
 <20170719121412.1d89857c@roar.ozlabs.ibm.com>
 <20170719050459.GA30836@in.ibm.com>
 <20170719152032.7724085f@roar.ozlabs.ibm.com>
Date: Tue, 25 Jul 2017 20:46:19 +1000
Message-ID: <8760eg7q10.fsf@concordia.ellerman.id.au>
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

Nicholas Piggin <npiggin@gmail.com> writes:
...
> I wonder if we should think about a more structured kernel API for
> modifying these kind of system registers so we always have the
> up-to-date values stored in memory. Many of them do need to be
> restored after sleep, but they don't need to be saved per-thread
> or saved every time we go to sleep.

Yes that's on my mental TODO. Paul and I have talked about it in the
past for KVM.

I'll write it down sometime so we at least remember :D

chers
