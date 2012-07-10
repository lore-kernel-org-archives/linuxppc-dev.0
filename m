Return-Path: <B16395@freescale.com>
Received: from ch1outboundpool.messaging.microsoft.com
 (ch1ehsobe005.messaging.microsoft.com [216.32.181.185])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 82A572C01B4
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 10 Jul 2012 19:39:37 +1000 (EST)
From: Sethi Varun-B16395 <B16395@freescale.com>
To: Kumar Gala <galak@kernel.crashing.org>, Wood Scott-B07421
 <B07421@freescale.com>
Subject: RE: [PATCH 3/3 v2] powerpc/mpic: FSL MPIC error interrupt support.
Date: Tue, 10 Jul 2012 09:39:25 +0000
Message-ID: <C5ECD7A89D1DC44195F34B25E172658D139C36@039-SN2MPN1-013.039d.mgd.msft.net>
References: <1341823643-15737-1-git-send-email-Varun.Sethi@freescale.com>
 <62D13F27-5E39-450E-953D-102DCA32AA9D@kernel.crashing.org>
 <4FFB3D88.6030106@freescale.com>
 <22EF3A64-2185-4078-B7B9-00E00D32604A@kernel.crashing.org>
In-Reply-To: <22EF3A64-2185-4078-B7B9-00E00D32604A@kernel.crashing.org>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Cc: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 Hamciuc Bogdan-BHAMCIU1 <bhamciu1@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



> -----Original Message-----
> From: Kumar Gala [mailto:galak@kernel.crashing.org]
> Sent: Tuesday, July 10, 2012 7:17 AM
> To: Wood Scott-B07421
> Cc: Sethi Varun-B16395; Hamciuc Bogdan-BHAMCIU1; linuxppc-
> dev@lists.ozlabs.org
> Subject: Re: [PATCH 3/3 v2] powerpc/mpic: FSL MPIC error interrupt
> support.
>=20
>=20
> On Jul 9, 2012, at 3:22 PM, Scott Wood wrote:
>=20
> > On 07/09/2012 02:03 PM, Kumar Gala wrote:
> >>
> >> On Jul 9, 2012, at 3:47 AM, Varun Sethi wrote:
> >>
> >>> +int mpic_err_int_init(struct mpic *mpic, irq_hw_number_t irqnum) {
> >>
> >> Why can't we do this during mpic_init() time?
> >
> > Are you willing to hardcode that IRQ 16 is the error interrupt,
> > without waiting to see an intspec?
>=20
> I'm torn, but the bit of code in mpic_host_xlate that calls
> mpic_err_int_init() is just ugly.
>=20
> We could consider it similar to how we assume IPIs.
[Sethi Varun-B16395] I don't understand this point.

-Varun
