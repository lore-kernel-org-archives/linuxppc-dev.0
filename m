Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 9C1B01007D1
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  8 Dec 2011 18:46:39 +1100 (EST)
Subject: Re: [linuxppc-release] [powerpc] boot up problem
Mime-Version: 1.0 (Apple Message framework v1251.1)
Content-Type: text/plain; charset=us-ascii
From: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <2870B32F-1A57-49DC-AD70-D3DB186F3DEA@freescale.com>
Date: Thu, 8 Dec 2011 01:46:49 -0600
Message-Id: <424AED74-3CB3-4F95-BF3C-830B45169269@kernel.crashing.org>
References: <1320040492-6407-1-git-send-email-B38951@freescale.com>
 <1320040492-6407-2-git-send-email-B38951@freescale.com>
 <412C8208B4A0464FA894C5F0C278CD5DFD4DB8@039-SN1MPN1-005.039d.mgd.msft.net>
 <3E825AD9-1CD5-4D6D-8161-E6B4F1D32457@kernel.crashing.org>
 <3F607A5180246847A760FD34122A1E052DBCD1@039-SN1MPN1-003.039d.mgd.msft.net>
 <412C8208B4A0464FA894C5F0C278CD5DFD6BAB@039-SN1MPN1-005.039d.mgd.msft.net>
 <3EC6F9E0-C847-4DA8-AD8C-313976982A10@kernel.crashing.org>
 <412C8208B4A0464FA894C5F0C278CD5DFDC478@039-SN1MPN1-005.039d.mgd.msft.net>
 <4ED84C32.3010807@freescale.com>
 <412C8208B4A0464FA894C5F0C278CD5DFE170A@039-SN1MPN1-005.039d.mgd.msft.net>
 <2870B32F-1A57-49DC-AD70-D3DB186F3DEA@freescale.com>
To: Timur Tabi <timur@freescale.com>
Cc: Fleming Andy-AFLEMING <afleming@freescale.com>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 Li Yang-R58472 <r58472@freescale.com>,
 Jia Hongtao-B38951 <B38951@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Dec 7, 2011, at 9:13 AM, Timur Tabi wrote:

> On Dec 7, 2011, at 1:27 AM, Jia Hongtao-B38951 <B38951@freescale.com> =
wrote:
>=20
>> Is this the patch you mentioned?
>> http://patchwork.ozlabs.org/patch/128806/
>>=20
>> I applied this patch but the issue was still there.
>=20
> This is not the patch I am talking about.  Unfortunately, I can't find =
the right patch in patchwork anywhere.
>=20
> Andy, what about patch "fsl_pq_mdio: Clean up tbi address =
configuration"? =20

I've pulled things into my 'test' branch of powerpc.git.  This should =
have the fixes to allow things to boot again.

- k=
