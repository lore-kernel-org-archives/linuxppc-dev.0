Return-Path: <glikely@secretlab.ca>
Received: from hs-out-0708.google.com (hs-out-0708.google.com [64.233.178.249])
	by ozlabs.org (Postfix) with ESMTP id 157F3DDF66
	for <linuxppc-dev@ozlabs.org>; Wed, 23 Apr 2008 06:27:01 +1000 (EST)
Received: by hs-out-0708.google.com with SMTP id z77so1577237hsz.9
	for <linuxppc-dev@ozlabs.org>; Tue, 22 Apr 2008 13:26:59 -0700 (PDT)
Message-ID: <fa686aa40804221326k14b095adk6a5ef5ccf9cd2a17@mail.gmail.com>
Date: Tue, 22 Apr 2008 14:26:59 -0600
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@secretlab.ca
To: "Scott Wood" <scottwood@freescale.com>
Subject: Re: [RFC POWERPC] booting-without-of: bindings for FHCI USB, GPIO LEDs,
	MCU, and NAND on UPM
In-Reply-To: <20080422202023.GA23165@ld0162-tx32.am.freescale.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <20080422194135.GA27822@polina.dev.rtsoft.ru>
	<fa686aa40804221308w5960ces1f03a6a8c049edd4@mail.gmail.com>
	<20080422202023.GA23165@ld0162-tx32.am.freescale.net>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, Apr 22, 2008 at 2:20 PM, Scott Wood <scottwood@freescale.com> wrote:
> On Tue, Apr 22, 2008 at 02:08:45PM -0600, Grant Likely wrote:
>  > > +    Example:
>  > > +
>  > > +       usb-pram@8b00 {
>  > > +               compatible = "fsl,mpc8360-qe-muram-usb-pram",
>  > > +                            "fsl,qe-muram-usb-pram",
>  > > +                            "fsl,cpm-muram-usb-pram";
>  > > +               reg = <0x8b00 0x100>;
>  > > +       };
>
>  Why not put it as an additional reg resource on the ucc node, instead of
>  in its own node?  That's how existing CPM bindings do it.

hmmm, yeah, that sounds like a better approach.

>
>  > > +    t) Freescale QUICC Engine USB Controller
>  > > +
>  > > +    Required properties:
>  > > +      - compatible : should be "fsl,<chip>-qe-usb", "fsl,qe-usb",
>  > > +        "fsl,usb-fhci"
>  >
>  > Again, I'd leave out "fsl,qe-usb" and "fsl,usb-fhci".
>
>  QE is the name of a specific IP block, and is unlikely to be broken in a
>  non-backwards-compatible manner without having a new name such as QE2.  I
>  think this is taking "no generic names" too far.

I'll just leave my comment as "I disagree" and resist the temptation
to rehash my argument.  :-)

>  If these names *are*
>  left out, then at least document which chip we're supposed to pick out of
>  a hat to claim compatibility with.

I agree with that.

>
>  -Scott
>



-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
