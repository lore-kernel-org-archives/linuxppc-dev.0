Return-Path: <christophe.leroy@c-s.fr>
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 414x4t6KjRzF4kK
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 Jun 2018 03:02:04 +1000 (AEST)
Subject: Re: [PATCH v6 3/4] powerpc/lib: implement strlen() in assembly
To: Segher Boessenkool <segher@kernel.crashing.org>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 wei.guo.simon@gmail.com, linux-kernel@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org
References: <85de16f5629ac9f4a815230cced361908758b53a.1528791416.git.christophe.leroy@c-s.fr>
 <8b89f2e21f7e3a865105eeeeda509243db393454.1528791416.git.christophe.leroy@c-s.fr>
 <20180612145315.GJ27520@gate.crashing.org>
From: Christophe LEROY <christophe.leroy@c-s.fr>
Message-ID: <baaf4fa9-ff0b-0bcb-8662-dafb794caab4@c-s.fr>
Date: Tue, 12 Jun 2018 19:01:59 +0200
MIME-Version: 1.0
In-Reply-To: <20180612145315.GJ27520@gate.crashing.org>
Content-Type: text/plain; charset=utf-8; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



Le 12/06/2018 à 16:53, Segher Boessenkool a écrit :
> On Tue, Jun 12, 2018 at 09:14:53AM +0000, Christophe Leroy wrote:
>> ---
>> Not tested on PPC64.
> 
> It won't be acceptable until that happens.  It also is likely quite bad
> performance on all 64-bit CPUs from the last fifteen years or so.  Or you
> did nothing to prove otherwise, at least.

Will it be as bad as the generic implementation which does it byte per 
byte ?

I don't have any 64 bits target, can someone test it using the test app 
I have added in selftests ?

Or should I just leave it as is for 64 bits and just do the 
implementation for 32 bits until someone wants to try and do it for PPC64 ?

Christophe

> 
>> + * Algorigthm:
> 
> Typo.
> 
> 
> Segher
> 
