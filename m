Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (bilbo.ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xYj5N3YC2zDqrS
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 18 Aug 2017 22:27:20 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Meelis Roos <mroos@linux.ee>,
 Linux Kernel list <linux-kernel@vger.kernel.org>, linux-fbdev@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org
Subject: Re: 32-bit powerpc, aty128fb: vmap allocation for size 135168 failed
In-Reply-To: <alpine.LRH.2.20.1708180825590.15982@math.ut.ee>
References: <alpine.LRH.2.20.1708180825590.15982@math.ut.ee>
Date: Fri, 18 Aug 2017 22:27:19 +1000
Message-ID: <87mv6xjc2g.fsf@concordia.ellerman.id.au>
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

Meelis Roos <mroos@linux.ee> writes:

> I was trying 4.13.0-rc5-00075-gac9a40905a61 on my PowerMac G4 with 1G 
> RAM and after some time of sddm respawning and X trying to restart, 
> dmesg is full of messages about vmap allocation failures.

Did it just start happening? ie. did rc4 work?

cheers
