Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41x2tZ1jtbzF2Dd
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 23 Aug 2018 21:56:06 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: ruscur@russell.cc <ruscur@russell.cc> andrew.donnellan@au1.ibm.com 
Cc: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, aneesh.kumar@linux.vnet.ibm.com,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 Christophe LEROY <christophe.leroy@c-s.fr>,
 Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH v2 3/4] powerpc/mm: fix a warning when a cache is common
 to PGD and hugepages
In-Reply-To: <8ada20e9-3bc1-fdaf-d78f-2f5a317e8216@c-s.fr>
References: <2f96bf1a8df1091c642de099ed07c34b5ab9b90a.1534258290.git.christophe.leroy@c-s.fr>
 <4aaca2d27429e6bdadc340fd3b96e7c350c4b2f4.1534258290.git.christophe.leroy@c-s.fr>
 <6dea8d0c-c4ab-49aa-da26-a729c18fa818@linux.ibm.com>
 <006e5f33-b816-7508-faac-da26a860659c@c-s.fr>
 <3e6412ac-c645-908f-a3bb-c9a2a72f4b68@linux.ibm.com>
 <cb121f38-ac89-4971-fd84-5473e7e9ced5@c-s.fr>
 <20180823103625.GR24439@gate.crashing.org>
 <8ada20e9-3bc1-fdaf-d78f-2f5a317e8216@c-s.fr>
Date: Thu, 23 Aug 2018 21:56:01 +1000
Message-ID: <87a7pdl2jy.fsf@concordia.ellerman.id.au>
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

> Le 23/08/2018 =C3=A0 12:36, Segher Boessenkool a =C3=A9crit=C2=A0:
>> On Thu, Aug 23, 2018 at 11:40:22AM +0200, Christophe LEROY wrote:
>>> The only small probl=C3=A8me I have is that some version of GCC seems to
>>> complain about big memset() (132k and 256k ones). Is there a way to tell
>>> GCC we really want to do it ?
>>=20
>> I'm not sure what you mean.  Complain, is that a warning, is that an err=
or?
>> What does it say?  Do you have some example code to reproduce it?  Etc.
>
> I saw the warnings in the checks at=20
> https://patchwork.ozlabs.org/patch/957566/
> Unfortunatly the link is now broken.

ruscur/ajd any idea what happened to the snowpatch links here?

cheers
