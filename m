Return-Path: <christophe.leroy@c-s.fr>
Received: from mailhub1.si.c-s.fr (2.236.17.93.rev.sfr.net [93.17.236.2])
 by lists.ozlabs.org (Postfix) with ESMTP id 48A9E1A001B
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  7 Oct 2015 01:12:24 +1100 (AEDT)
Subject: Re: [PATCH v2 13/25] powerpc/8xx: also use r3 in the ITLB miss in all
 situations
To: Scott Wood <scottwood@freescale.com>
References: <cover.1442939410.git.christophe.leroy@c-s.fr>
 <94728e239cad2224383db7ddc1c57df7d11561eb.1442939410.git.christophe.leroy@c-s.fr>
 <20150929000039.GG6161@home.buserror.net>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
From: Christophe Leroy <christophe.leroy@c-s.fr>
Message-ID: <5613D6C5.1030100@c-s.fr>
Date: Tue, 6 Oct 2015 16:12:21 +0200
MIME-Version: 1.0
In-Reply-To: <20150929000039.GG6161@home.buserror.net>
Content-Type: text/plain; charset=windows-1252; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



Le 29/09/2015 02:00, Scott Wood a écrit :
> On Tue, Sep 22, 2015 at 06:50:54PM +0200, Christophe Leroy wrote:
>> We are spending between 40 and 160 cycles with a mean of 65 cycles
>> in the TLB handling routines (measured with mftbl) so make it more
>> simple althought it adds one instruction
>>
>> Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
>> ---
>> No change in v2
>>
>>   arch/powerpc/kernel/head_8xx.S | 15 ++++-----------
>>   1 file changed, 4 insertions(+), 11 deletions(-)
> Why is this a separate patch from 1/25?
>
> Same comments as on that patch.
>
>
Just because here there is no real need behind the simplification of the 
code, whereas the first one was a pre-requisite for the following patch.
Should I merge them together anyway ?

Christophe
