Return-Path: <mikey@neuling.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tNhfD3n97zDvx6
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 23 Nov 2016 10:35:16 +1100 (AEDT)
Message-ID: <1479857716.6542.60.camel@neuling.org>
Subject: Re: [PATCH] powernv: Clear SPRN_PSSCR when a POWER9 CPU comes online
From: Michael Neuling <mikey@neuling.org>
To: Michael Ellerman <mpe@ellerman.id.au>, "Gautham R. Shenoy"
 <ego@linux.vnet.ibm.com>, Benjamin Herrenschmidt
 <benh@kernel.crashing.org>,  Paul Mackerras <paulus@samba.org>,
 Vaidyanathan Srinivasan <svaidy@linux.vnet.ibm.com>, "Shreyas B. Prabhu"
 <shreyasbp@gmail.com>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Date: Wed, 23 Nov 2016 10:35:16 +1100
In-Reply-To: <87bmx7um7s.fsf@concordia.ellerman.id.au>
References: <1479838000-380-1-git-send-email-ego@linux.vnet.ibm.com>
 <87bmx7um7s.fsf@concordia.ellerman.id.au>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2016-11-23 at 10:30 +1100, Michael Ellerman wrote:
> "Gautham R. Shenoy" <ego@linux.vnet.ibm.com> writes:
>=20
> > From: "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>
> >=20
> > Ensure that PSSCR is set to a safe value corresponding to no
> > state-loss each time a POWER9 CPU comes online.
>=20
> Is this a bug fix? I can't tell from the change log.

There are no known bugs it's fixing. =C2=A0

It's just safer to run with a known default value, rather than what we rand=
omly
inherit from previous firmware.

Mikey
