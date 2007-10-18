Return-Path: <glikely@secretlab.ca>
Received: from wa-out-1112.google.com (wa-out-1112.google.com [209.85.146.180])
	by ozlabs.org (Postfix) with ESMTP id 3BCB4DDEBE
	for <linuxppc-dev@ozlabs.org>; Thu, 18 Oct 2007 23:16:06 +1000 (EST)
Received: by wa-out-1112.google.com with SMTP id m28so197465wag
	for <linuxppc-dev@ozlabs.org>; Thu, 18 Oct 2007 06:16:05 -0700 (PDT)
Message-ID: <fa686aa40710180616re8e3c5ib92ab2700d98e260@mail.gmail.com>
Date: Thu, 18 Oct 2007 07:16:04 -0600
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@secretlab.ca
To: "Wolfgang Grandegger" <wg@grandegger.com>
Subject: Re: [PATCH 07/15] [POWERPC] Promess Motion-PRO DTS
In-Reply-To: <47175683.1030407@grandegger.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <47075FA7.3030108@semihalf.com> <4708C22D.5060805@semihalf.com>
	<47175683.1030407@grandegger.com>
Cc: linuxppc-dev@ozlabs.org, Marian Balakowicz <m8@semihalf.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On 10/18/07, Wolfgang Grandegger <wg@grandegger.com> wrote:
> Hello,
>
> I see one more issue.
>
> Marian Balakowicz wrote:
> > Add device tree source file for Motion-PRO board.
> >
> > Signed-off-by: Marian Balakowicz <m8@semihalf.com>
> > ---
> [deletions]
> > +             gpio@b00 {
> > +                     compatible = "mpc5200b-gpio\0mpc5200-gpio";
> > +                     reg = <b00 40>;
> > +                     interrupts = <1 7 0>;
> > +                     interrupt-parent = <&mpc5200_pic>;
> > +             };
>
> Do we not need the field "device_type = "gpio" here?
>
> > +             gpio-wkup@c00 {
> > +                     compatible = "mpc5200b-gpio-wkup\0mpc5200-gpio-wkup";
> > +                     reg = <c00 40>;
> > +                     interrupts = <1 8 0 0 3 0>;
> > +                     interrupt-parent = <&mpc5200_pic>;
> > +             };
>
> And the same here.

'GPIO' is not a standard device type (at least there are no standard
set of GPIO bindings defined) so the device_type field should be
omitted.  Compatible is sufficient.

Cheers,
g.

-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
grant.likely@secretlab.ca
(403) 399-0195
