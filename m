Return-Path: <mikey@neuling.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 9C4881A04F3
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  3 Dec 2015 09:37:28 +1100 (AEDT)
Message-ID: <1449095848.30090.119.camel@neuling.org>
Subject: Re: [PATCH 00/19] Context switch improvements
From: Michael Neuling <mikey@neuling.org>
To: Anshuman Khandual <khandual@linux.vnet.ibm.com>, Anton Blanchard
 <anton@samba.org>, benh@kernel.crashing.org, paulus@samba.org,
 mpe@ellerman.id.au,  cyrilbur@gmail.com, scottwood@freescale.com
Cc: linuxppc-dev@lists.ozlabs.org
Date: Thu, 03 Dec 2015 09:37:28 +1100
In-Reply-To: <565EAF03.5010104@linux.vnet.ibm.com>
References: <1446079451-8774-1-git-send-email-anton@samba.org>
 <565EAF03.5010104@linux.vnet.ibm.com>
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

On Wed, 2015-12-02 at 14:12 +0530, Anshuman Khandual wrote:
> On 10/29/2015 06:13 AM, Anton Blanchard wrote:
> > Here are various improvements to our context switch path. Some of
> > the
> > highlights:
> >=20
> > - Group all mfsprs and mtsprs in __switch_to(), which gives us a
> >   10% improvement on POWER8.
> >=20
> > - Create giveup_all() and flush_all_to_thread() so we only write
> > the
> >   MSR once, which gives us a 3% improvement on POWER8.
> >=20
> > - Create disable_kernel_{fp,altivec,vsx,spe}() and add a debug boot
> >   option (ppc_strict_facility_enable) to minimise kernel code
> > running
> >   with floating point and vector bits enabled.
> >=20
> > - Make giveup_vsx() and flush_vsx_to_thread() handle FP and Altivec
> >   state, so they behave more like their sister functions.
> >=20
> > Scott: There are changes to the SPE code here which I have only
> > been
> > able to compile test.
>=20
> Hey Anton,
>=20
> Wondering if you have a git tree hosted some where to pull these
> patches ?

The 0day bot does this automatically for you...

https://github.com/0day-ci/linux/tree/Anton-Blanchard/Context-switch-improv=
ements/20151029-092229

Mikey
