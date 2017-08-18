Return-Path: <mroos@linux.ee>
Received: from smtp1.it.da.ut.ee (mailhost6-1.ut.ee
 [IPv6:2001:bb8:2002:500::46])
 by lists.ozlabs.org (Postfix) with ESMTP id 3xYj7w70GczDqYw
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 18 Aug 2017 22:29:32 +1000 (AEST)
Date: Fri, 18 Aug 2017 15:29:28 +0300 (EEST)
From: Meelis Roos <mroos@linux.ee>
Sender: mroos@math.ut.ee
To: Michael Ellerman <mpe@ellerman.id.au>
cc: Linux Kernel list <linux-kernel@vger.kernel.org>,
 linux-fbdev@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: 32-bit powerpc, aty128fb: vmap allocation for size 135168 failed
In-Reply-To: <87mv6xjc2g.fsf@concordia.ellerman.id.au>
Message-ID: <alpine.LRH.2.20.1708181528380.17590@math.ut.ee>
References: <alpine.LRH.2.20.1708180825590.15982@math.ut.ee>
 <87mv6xjc2g.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

> > I was trying 4.13.0-rc5-00075-gac9a40905a61 on my PowerMac G4 with 1G 
> > RAM and after some time of sddm respawning and X trying to restart, 
> > dmesg is full of messages about vmap allocation failures.
> 
> Did it just start happening? ie. did rc4 work?

No, rc4 was the first one I tried after 4.12 and it already had the 
problem. Not sure about 4.12 to be honest, will soee some day.

-- 
Meelis Roos (mroos@linux.ee)
