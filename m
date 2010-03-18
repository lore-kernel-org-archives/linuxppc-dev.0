Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 97912B7CFB
	for <linuxppc-dev@ozlabs.org>; Thu, 18 Mar 2010 18:08:42 +1100 (EST)
Subject: Re: [PATCH] powerpc/fsl-booke: Get coherent bit from PTE
Mime-Version: 1.0 (Apple Message framework v1077)
Content-Type: text/plain; charset=us-ascii
From: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <4BA1D00F.1090809@neli.hopto.org>
Date: Thu, 18 Mar 2010 02:08:27 -0500
Message-Id: <B78FE0E1-5B67-4DBE-9318-91280F2BB7C9@kernel.crashing.org>
References: <1268800916-14247-1-git-send-email-galak@kernel.crashing.org>
	<4BA1D00F.1090809@neli.hopto.org>
To: Micha Nelissen <micha@neli.hopto.org>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Mar 18, 2010, at 2:02 AM, Micha Nelissen wrote:

> Kumar Gala wrote:
>> We shouldn't be always setting 'M' in the TLB entry since its =
reasonable
>> for somethings to be mapped non-coherent.  The PTE should have 'M' =
set
>> properly.
>=20
> properly =3D not at all? AFAICS the patch only removes the setting of =
the bit; so where is that 'M' bit set then?
>=20
> Micha

Its set via things like the _PAGE_BASE define in =
arch/powerpc/include/asm/pte-common.h

- k=
