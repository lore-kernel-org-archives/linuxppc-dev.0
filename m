Return-Path: <christophe.leroy@c-s.fr>
Received: from mailhub1.si.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 by lists.ozlabs.org (Postfix) with ESMTP id ACF161A009E
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 18 Sep 2014 06:33:42 +1000 (EST)
Message-ID: <5419F017.8010603@c-s.fr>
Date: Wed, 17 Sep 2014 22:33:27 +0200
From: christophe leroy <christophe.leroy@c-s.fr>
MIME-Version: 1.0
To: Scott Wood <scottwood@freescale.com>
Subject: Re: [PATCH v3 00/21] powerpc/8xx: Optimise MMU TLB handling and add
 support of 16k pages
References: <20140917163656.E09D81AB026@localhost.localdomain>
 <1410972043.24184.532.camel@snotra.buserror.net>
In-Reply-To: <1410972043.24184.532.camel@snotra.buserror.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Cc: linuxppc-dev@lists.ozlabs.org, Paul Mackerras <paulus@samba.org>,
 linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


Le 17/09/2014 18:40, Scott Wood a écrit :
> On Wed, 2014-09-17 at 18:36 +0200, Christophe Leroy wrote:
>> This patchset:
>> 1) provides several MMU TLB handling optimisation on MPC8xx.
>> 2) adds support of 16k pages on MPC8xx.
>> All changes have been successfully tested on a custom board equipped with MPC885
>>
>> Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
>> Tested-by: Christophe Leroy <christophe.leroy@c-s.fr>
> I've already applied patches 1, 2, 4, 5, 6, 9, and 10 from the previous
> patchset -- have they changed?
>
> -Scott
>
No, only 3, 7, 17 are changed, and 20,21 are new.
I didn't notice you already applied some. How should I then proceed now 
for the remaining ones ? Submit a new set ?

Thanks
Christophe

---
Ce courrier électronique ne contient aucun virus ou logiciel malveillant parce que la protection avast! Antivirus est active.
http://www.avast.com
