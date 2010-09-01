Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 32ACFB7159
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed,  1 Sep 2010 23:12:50 +1000 (EST)
Subject: Re: [linuxppc-release] [PATCH 1/2] powerpc/mm: Assume first cpu is
	boot_cpuid not 0
Mime-Version: 1.0 (Apple Message framework v1081)
Content-Type: text/plain; charset=us-ascii
From: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <4C7E4FA4.60909@freescale.com>
Date: Wed, 1 Sep 2010 08:12:44 -0500
Message-Id: <4AB7AB1A-B3DC-4B24-84A6-4B1679C242E3@kernel.crashing.org>
References: <1283297085-3455-1-git-send-email-msm@freescale.com>
	<4C7E4FA4.60909@freescale.com>
To: Timur Tabi <timur@freescale.com>
Cc: Matthew McClintock <msm@freescale.com>, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Sep 1, 2010, at 8:05 AM, Timur Tabi wrote:

> Matthew McClintock wrote:
>> +#ifndef CONFIG_SMP
>> 	stale_map[0] =3D alloc_bootmem(CTX_MAP_SIZE);
>> +#else
>> +	stale_map[boot_cpuid] =3D alloc_bootmem(CTX_MAP_SIZE);
>=20
> So you're saying that even on a non-SMP kernel, boot_cpuid might not =
be zero?

That is correct, we have that situation on AMP kernel boots on 8572, =
p2020, etc.

- k=
