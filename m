Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40xTkn4V73zDrYf
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  1 Jun 2018 00:05:37 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Venkat Rao B <vrbagal1@linux.vnet.ibm.com>,
 Christophe LEROY <christophe.leroy@c-s.fr>, linuxppc-dev@lists.ozlabs.org
Cc: sfr@canb.auug.org.au
Subject: Re: Build Failure on linux-next on Power8 machine
In-Reply-To: <1fd71673-9e1e-9f95-057e-ed8fb87e503d@linux.vnet.ibm.com>
References: <d377489b3333eca0951510c19b7d8878@linux.vnet.ibm.com>
 <5abede57-06bd-bb3c-385e-11a61a380027@c-s.fr>
 <1fd71673-9e1e-9f95-057e-ed8fb87e503d@linux.vnet.ibm.com>
Date: Fri, 01 Jun 2018 00:05:36 +1000
Message-ID: <8736y7zzrj.fsf@concordia.ellerman.id.au>
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

Venkat Rao B <vrbagal1@linux.vnet.ibm.com> writes:
> On Thursday 31 May 2018 04:44 PM, Christophe LEROY wrote:
>> Le 31/05/2018 =C3=A0 12:38, vrbagal1 a =C3=A9crit=C2=A0:
>>> Greetings!!!
>>>
>>> I am observing a build failure on linux-next kernel.
>>>
>>> Machine: Power8
>>> Platform: PowerNV(Baremetal)
>>> Git Tree:=20
>>> https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git
>>=20
>> Which defconfig do you use, or can you give your .config ?
>>=20
>> Christophe
>>=20
>>=20
> Unfortunately I lost it. I  only have complete fail logs. Will that be=20
> helpful?

We really need the .config, or at least some idea of which config it is.

We also really need to know which exact revision you're building.
linux-next is updated every day.

Today's build results are here:

  http://kisskb.ellerman.id.au/kisskb/head/14032/


I don't see any fails that look similar to yours. So perhaps you're
using a different compiler or something. That's another detail you
should tell us, the exact compiler version :)

cheers
