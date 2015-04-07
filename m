Return-Path: <christophe.leroy@c-s.fr>
Received: from mailhub1.si.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 by lists.ozlabs.org (Postfix) with ESMTP id 0AC2E1A03D6
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  7 Apr 2015 18:08:11 +1000 (AEST)
Message-ID: <5523905E.6050007@c-s.fr>
Date: Tue, 07 Apr 2015 10:07:58 +0200
From: leroy christophe <christophe.leroy@c-s.fr>
MIME-Version: 1.0
To: Scott Wood <scottwood@freescale.com>
Subject: Re: powerpc32: fix warning from include/linux/mm.h
References: <20141205112020.640FA1A5D4F@localhost.localdomain>
 <20150320235213.GA1233@home.buserror.net>
In-Reply-To: <20150320235213.GA1233@home.buserror.net>
Content-Type: text/plain; charset=windows-1252; format=flowed
Cc: Paul Mackerras <paulus@samba.org>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


Le 21/03/2015 00:52, Scott Wood a écrit :
> On Fri, Dec 05, 2014 at 12:20:20PM +0100, LEROY Christophe wrote:
>> include/linux/mm.h: In function 'is_vmalloc_addr':
>> include/linux/mm.h:367:14: warning: comparison between signed and unsigned integer expressions [-Wsign-compare]
>>    return addr >= VMALLOC_START && addr < VMALLOC_END;
>>                ^
>>
>> Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
>> ---
>>   arch/powerpc/include/asm/pgtable-ppc32.h | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
> That warning doesn't appear to be enabled.  What config are you seeing
> this with?
I'm used to adding EXTRA_CFLAGS=-Wextra  when checking my own drivers, 
as it helps finding additional bugs.

When doing that, the only warnings I get outside of my own code are this 
one, and the other one in my proposed patch identified "powerpc32: fix 
warning from include/asm-generic/termios-base.h"

I though it would be worth fixing those two warnings in order to get a 
perfectly clean code.

Christophe
