Return-Path: <christophe.leroy@c-s.fr>
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42Dsb82WYtzF1RN
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 18 Sep 2018 15:52:36 +1000 (AEST)
Subject: Re: [PATCH] powerpc/makefile: remove check on obsolete GCC versions
To: Joel Stanley <joel@jms.id.au>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 linuxppc-dev@lists.ozlabs.org,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <82bbb913ffd8bdc040a012152ee968cd0c6ccf4e.1537218487.git.christophe.leroy@c-s.fr>
 <CACPK8XdeT_FF_PHjqOh3e18jDhsFOdECVDd+Z2vWt8pSk5damA@mail.gmail.com>
From: Christophe LEROY <christophe.leroy@c-s.fr>
Message-ID: <1ede3510-df2a-183a-dd4b-3276041d8910@c-s.fr>
Date: Tue, 18 Sep 2018 07:52:31 +0200
MIME-Version: 1.0
In-Reply-To: <CACPK8XdeT_FF_PHjqOh3e18jDhsFOdECVDd+Z2vWt8pSk5damA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



Le 18/09/2018 à 07:48, Joel Stanley a écrit :
> Hey Christophe,
> 
> On Tue, 18 Sep 2018 at 15:13, Christophe Leroy <christophe.leroy@c-s.fr> wrote:
>>
>> Since commit cafa0010cd51 ("Raise the minimum required gcc version
>> to 4.6"), it is not possible to build kernel with GCC lower than 4.6
>>
>> This patch removes checkbin tests addressing older versions of GCC.
> 
> This is the same as Nick's patch:
> 
>   https://patchwork.ozlabs.org/patch/969624/
> 

Oops, thanks, I missed that.

And even before Nick's, there is this one 
https://patchwork.ozlabs.org/patch/962319/

So I missed twice :(

Christophe
