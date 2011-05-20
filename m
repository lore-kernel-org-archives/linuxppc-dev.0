Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id D22DBB71A0
	for <linuxppc-dev@ozlabs.org>; Sat, 21 May 2011 05:20:59 +1000 (EST)
Subject: Re: [PATCH 02/14] powerpc: Add a defconfig for 'corenet' 32-bit
	platforms
Mime-Version: 1.0 (Apple Message framework v1084)
Content-Type: text/plain; charset=us-ascii
From: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <BANLkTimzQ3PUpJQB_sF+PM9DAL+kAYgDYw@mail.gmail.com>
Date: Fri, 20 May 2011 14:20:56 -0500
Message-Id: <64A1571F-0AF7-4717-8D6F-4A980E09DFE0@kernel.crashing.org>
References: <1305871771-16334-1-git-send-email-galak@kernel.crashing.org>
	<1305871771-16334-2-git-send-email-galak@kernel.crashing.org>
	<BANLkTimzQ3PUpJQB_sF+PM9DAL+kAYgDYw@mail.gmail.com>
To: Tabi Timur-B04825 <B04825@freescale.com>
Cc: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On May 20, 2011, at 9:45 AM, Tabi Timur-B04825 wrote:

> On Fri, May 20, 2011 at 1:09 AM, Kumar Gala =
<galak@kernel.crashing.org> wrote:
>=20
>> +CONFIG_MATH_EMULATION=3Dy
>=20
> Don't these chips have hardware floating point?

Darn, I thought I looked at that.  Will fix.

>> +CONFIG_FORCE_MAX_ZONEORDER=3D13
>=20
> This may be unnecessary.  I originally set CONFIG_FORCE_MAX_ZONEORDER
> to 12 because the DIU driver needs to be able to allocate a contiguous
> 5MB memory block.  Setting it to 13 means a max of 16MB.  Is there a
> reason the default isn't good enough?

Is there some concern here?  CONFIG_FORCE_MAX_ZONE_ORDER was set to 13 =
because of hugetlbfs=
