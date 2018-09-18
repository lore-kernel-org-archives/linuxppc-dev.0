Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42F0CD21RHzF0pD
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 18 Sep 2018 20:50:48 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Christophe LEROY <christophe.leroy@c-s.fr>, Joel Stanley <joel@jms.id.au>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, linuxppc-dev@lists.ozlabs.org,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] powerpc/makefile: remove check on obsolete GCC versions
In-Reply-To: <1ede3510-df2a-183a-dd4b-3276041d8910@c-s.fr>
References: <82bbb913ffd8bdc040a012152ee968cd0c6ccf4e.1537218487.git.christophe.leroy@c-s.fr>
 <CACPK8XdeT_FF_PHjqOh3e18jDhsFOdECVDd+Z2vWt8pSk5damA@mail.gmail.com>
 <1ede3510-df2a-183a-dd4b-3276041d8910@c-s.fr>
Date: Tue, 18 Sep 2018 20:50:44 +1000
Message-ID: <87va73axkr.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Christophe LEROY <christophe.leroy@c-s.fr> writes:
> Le 18/09/2018 =C3=A0 07:48, Joel Stanley a =C3=A9crit=C2=A0:
>> Hey Christophe,
>>=20
>> On Tue, 18 Sep 2018 at 15:13, Christophe Leroy <christophe.leroy@c-s.fr>=
 wrote:
>>>
>>> Since commit cafa0010cd51 ("Raise the minimum required gcc version
>>> to 4.6"), it is not possible to build kernel with GCC lower than 4.6
>>>
>>> This patch removes checkbin tests addressing older versions of GCC.
>>=20
>> This is the same as Nick's patch:
>>=20
>>   https://patchwork.ozlabs.org/patch/969624/
>>=20
>
> Oops, thanks, I missed that.
>
> And even before Nick's, there is this one=20
> https://patchwork.ozlabs.org/patch/962319/
>
> So I missed twice :(

Haha, I missed that one too.

Everyone loves deleting code ;)

I have Nick's patch queued.

cheers
