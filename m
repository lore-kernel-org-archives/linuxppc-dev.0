Return-Path: <B07421@freescale.com>
Received: from db8outboundpool.messaging.microsoft.com
 (mail-db8lp0189.outbound.messaging.microsoft.com [213.199.154.189])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "MSIT Machine Auth CA 2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 446602C009D
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  7 Jun 2013 05:58:04 +1000 (EST)
Date: Thu, 6 Jun 2013 14:57:54 -0500
From: Scott Wood <scottwood@freescale.com>
Subject: Re: [RFC PATCH 0/6] KVM: PPC: Book3E: AltiVec support
To: Caraman Mihai Claudiu-B02008 <B02008@freescale.com>
References: <1370292868-2697-1-git-send-email-mihai.caraman@freescale.com>
 <1370381959.748.16@snotra>
 <300B73AA675FCE4A93EB4FC1D42459FF44EB49@039-SN2MPN1-011.039d.mgd.msft.net>
 <1370450103.26139.0@snotra>
 <300B73AA675FCE4A93EB4FC1D42459FF453564@039-SN2MPN1-011.039d.mgd.msft.net>
In-Reply-To: <300B73AA675FCE4A93EB4FC1D42459FF453564@039-SN2MPN1-011.039d.mgd.msft.net>
 (from B02008@freescale.com on Thu Jun  6 04:42:44 2013)
Message-ID: <1370548674.21533.17@snotra>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; delsp=Yes; format=Flowed
Cc: Wood Scott-B07421 <B07421@freescale.com>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
 "kvm-ppc@vger.kernel.org" <kvm-ppc@vger.kernel.org>,
 Alexander Graf <agraf@suse.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 06/06/2013 04:42:44 AM, Caraman Mihai Claudiu-B02008 wrote:
> > > > This looks like a bit much for 3.10 (certainly, subject lines =20
> like
> > > > "refactor" and "enhance" and "add support" aren't going to make
> > > Linus
> > > > happy given that we're past rc4) so I think we should apply
> > > > http://patchwork.ozlabs.org/patch/242896/ for 3.10.  Then for =20
> 3.11,
> > > > revert it after applying this patchset.
> > > >
> > >
> > > Why not 1/6 plus e6500 removal?
> >
> > 1/6 is not a bugfix.
>=20
> Not sure I get it. Isn't this a better fix for AltiVec build breakage:
>=20
> -#define BOOKE_INTERRUPT_ALTIVEC_UNAVAIL 42
> -#define BOOKE_INTERRUPT_ALTIVEC_ASSIST 43
> +#define BOOKE_INTERRUPT_ALTIVEC_UNAVAIL 32
> +#define BOOKE_INTERRUPT_ALTIVEC_ASSIST 33
>=20
> This removes the need for additional kvm_handlers. Obvious this =20
> doesn't make
> AltiVec to work so we still need to disable e6500.

OK, didn't realize you meant it as an alternative fix to what was in my =20
patch.

-Scott=
