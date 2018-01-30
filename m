Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zVqcB3WdTzDqpD
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 30 Jan 2018 13:11:06 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Christian Zigotzky <chzigotzky@xenosoft.de>, linuxppc-dev@ozlabs.org
Cc: mikey@neuling.org, peterz@infradead.org, linux-kernel@vger.kernel.org,
 npiggin@gmail.com, oohall@gmail.com, anton@samba.org, paulus@samba.org,
 tglx@linutronix.de
Subject: Re: [PATCH 07/11] powerpc/64s: Add support for RFI flush of L1-D cache
In-Reply-To: <d73cc972-420d-4106-cc08-0d0683435afa@xenosoft.de>
References: <20180108165453.26066-1-mpe@ellerman.id.au>
 <20180108165453.26066-7-mpe@ellerman.id.au>
 <d73cc972-420d-4106-cc08-0d0683435afa@xenosoft.de>
Date: Tue, 30 Jan 2018 13:11:05 +1100
Message-ID: <87mv0w85ae.fsf@concordia.ellerman.id.au>
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

Christian Zigotzky <chzigotzky@xenosoft.de> writes:

> FYI:
>
> A-EON AmigaOne X1000 (CPU P.A. Semi PWRficient PA6T-1682M with two PA6T 
> cores):
>
> /sys/devices/system/cpu/vulnerabilities/
>
> -r--r--r-- 1 root root 4096 Jan 25 09:38 meltdown
> -r--r--r-- 1 root root 4096 Jan 25 09:38 spectre_v1
> -r--r--r-- 1 root root 4096 Jan 25 09:38 spectre_v2
>
> meltdown Vulnerable
> spectre_v1 Not affected
> spectre_v2 Not affected

Which may or may not be true, this is still all a work in progress.

cheers
