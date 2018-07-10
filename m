Return-Path: <chzigotzky@xenosoft.de>
Received: from mo6-p02-ob.smtp.rzone.de (mo6-p02-ob.smtp.rzone.de
 [IPv6:2a01:238:20a:202:5302::4])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41Q84F3nkNzDr0d
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 11 Jul 2018 03:16:12 +1000 (AEST)
Content-Type: text/plain;
	charset=utf-8
Mime-Version: 1.0 (1.0)
Subject: [PATCH NEXT 1/4] powerpc/pasemi: Add PCI initialisation for Nemo
 board.
From: Christian Zigotzky <chzigotzky@xenosoft.de>
In-Reply-To: <871scbb3ob.fsf@concordia.ellerman.id.au>
Date: Tue, 10 Jul 2018 19:15:57 +0200
Cc: Darren Stevens <darren@stevens-zone.net>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Message-Id: <196ECBF7-5001-4B0B-9FE3-F079CE0996EE@xenosoft.de>
References: <4b3d1ee02c7.3de0aa2c@auth.smtp.1and1.co.uk>
 <87k1skanxy.fsf@concordia.ellerman.id.au>
 <F7494DDC-BDA9-460A-94EB-6FAF58D673FA@xenosoft.de>
 <871scbb3ob.fsf@concordia.ellerman.id.au>
To: Michael Ellerman <mpe@ellerman.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hello Michael,

Thanks a lot for your reply. OK, first I would like to add=20

pr_info("NEMO SB600 IOB base %08llx\n",res.start)

to the Nemo patch. Is this line correct now?

After that I will try to contact Darren because of your other comments.

If I don=E2=80=99t reach Darren then I will try to fix the issues but I thin=
k I need your help for fixing them.

Thanks,
Christian

> On 10. Jul 2018, at 15:50, Michael Ellerman wrote:
>=20
> pr_info() would be nice.
>=20
> But I replied with lots of other comments previously.
>=20
> None of them were super critical, but it would be nice to get them fixed
> before merging if possible.
>=20
> cheers
