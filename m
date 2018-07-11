Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41Qgmy50mhzF35x
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 12 Jul 2018 00:04:50 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Christian Zigotzky <chzigotzky@xenosoft.de>
Cc: Darren Stevens <darren@stevens-zone.net>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Subject: Re: [PATCH NEXT 1/4] powerpc/pasemi: Add PCI initialisation for Nemo
 board.
In-Reply-To: <196ECBF7-5001-4B0B-9FE3-F079CE0996EE@xenosoft.de>
References: <4b3d1ee02c7.3de0aa2c@auth.smtp.1and1.co.uk>
 <87k1skanxy.fsf@concordia.ellerman.id.au>
 <F7494DDC-BDA9-460A-94EB-6FAF58D673FA@xenosoft.de>
 <871scbb3ob.fsf@concordia.ellerman.id.au>
 <196ECBF7-5001-4B0B-9FE3-F079CE0996EE@xenosoft.de>
Date: Thu, 12 Jul 2018 00:04:49 +1000
Message-ID: <87bmbdamwu.fsf@concordia.ellerman.id.au>
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

Christian Zigotzky <chzigotzky@xenosoft.de> writes:

> Hello Michael,
>
> Thanks a lot for your reply. OK, first I would like to add=20
>
> pr_info("NEMO SB600 IOB base %08llx\n",res.start)
>
> to the Nemo patch. Is this line correct now?

Yes I think so.

The type of start is resource_size_t, which can be 32 or 64-bits. But in
this code it should always be 64-bit.

> After that I will try to contact Darren because of your other comments.
>
> If I don=E2=80=99t reach Darren then I will try to fix the issues but I t=
hink
> I need your help for fixing them.

Sure.

cheers
