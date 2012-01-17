Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 31871B6F65
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 18 Jan 2012 05:57:48 +1100 (EST)
Subject: Re: [PATCH 2/2][v2] mtd/nand: Fix IFC driver to support 2K NAND page
Mime-Version: 1.0 (Apple Message framework v1251.1)
Content-Type: text/plain; charset=us-ascii
From: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <4F0B901C.6020100@freescale.com>
Date: Tue, 17 Jan 2012 12:57:36 -0600
Message-Id: <C8C27406-1682-4316-97D1-00EFB5898805@kernel.crashing.org>
References: <1326111866-13120-1-git-send-email-prabhakar@freescale.com>
 <4F0B901C.6020100@freescale.com>
To: Scott Wood <scottwood@freescale.com>
Cc: Poonam Aggrwal <poonam.aggrwal@freescale.com>,
 linuxppc-dev@lists.ozlabs.org, linux-mtd@lists.infradead.org,
 Prabhakar Kushwaha <prabhakar@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Jan 9, 2012, at 7:10 PM, Scott Wood wrote:

> On 01/09/2012 06:24 AM, Prabhakar Kushwaha wrote:
>> 1) OOB area should be updated irrespective of NAND page size. Earlier =
it was
>> updated only for 512byte NAND page.
>>=20
>> 2) During OOB update fbcr should be equal to OOB size.
>>=20
>> Signed-off-by: Poonam Aggrwal <poonam.aggrwal@freescale.com>
>> Signed-off-by: Prabhakar Kushwaha <prabhakar@freescale.com>
>> ---
>> git://git.kernel.org/pub/scm/linux/kernel/git/galak/powerpc.git =
(branch next)
>>=20
>> This patch is created on top of IFC driver patch (already floated in =
mailing
>> list). Please find their link:
>> http://patchwork.ozlabs.org/patch/133315/
>> http://patchwork.ozlabs.org/patch/133316/
>=20
> Looks good.
>=20
> -Scott

Can we not merge all these into one updated IFC NAND patch?

- k=
