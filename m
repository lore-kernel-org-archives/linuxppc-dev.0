Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (bilbo.ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xMCtG43VrzDrhD
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  1 Aug 2017 20:56:22 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>,
 Michael Neuling <mikey@neuling.org>, Nicholas Piggin <npiggin@gmail.com>,
 Vaidyanathan Srinivasan <svaidy@linux.vnet.ibm.com>,
 Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>,
 Akshay Adiga <akshay.adiga@linux.vnet.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>
Subject: Re: [v3 PATCH 1/2] powernv/powerpc:Save/Restore additional SPRs for
 stop4 cpuidle
In-Reply-To: <57ed82bcd92cd4d0af7ae5113710d597a331c433.1500631040.git.ego@linux.vnet.ibm.com>
References: <cover.1500631040.git.ego@linux.vnet.ibm.com>
 <57ed82bcd92cd4d0af7ae5113710d597a331c433.1500631040.git.ego@linux.vnet.ibm.com>
Date: Tue, 01 Aug 2017 20:56:18 +1000
Message-ID: <87r2wvsgj1.fsf@concordia.ellerman.id.au>
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

"Gautham R. Shenoy" <ego@linux.vnet.ibm.com> writes:
>
> Subject: [v3 PATCH 1/2] powernv/powerpc:Save/Restore additional SPRs for stop4 cpuidle

I know it's not a big deal, but can we agree on the subject format?

  powerpc/powernv: Save/Restore additional SPRs for stop4 cpuidle

cheers
