Return-Path: <glikely@secretlab.ca>
Received: from an-out-0708.google.com (an-out-0708.google.com [209.85.132.247])
	by ozlabs.org (Postfix) with ESMTP id CA2A5DDF5A
	for <linuxppc-dev@ozlabs.org>; Sat, 22 Mar 2008 14:47:30 +1100 (EST)
Received: by an-out-0708.google.com with SMTP id c37so395317anc.78
	for <linuxppc-dev@ozlabs.org>; Fri, 21 Mar 2008 20:47:25 -0700 (PDT)
Message-ID: <fa686aa40803212047q2ab338feseeb5e277bad1a7f1@mail.gmail.com>
Date: Fri, 21 Mar 2008 21:47:25 -0600
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@secretlab.ca
To: "Bartlomiej Sieka" <tur@semihalf.com>,
	"Grant Likely" <grant.likely@secretlab.ca>, linuxppc-dev@ozlabs.org,
	"Anatolij Gustschin" <agust@denx.de>, "Paul Mackerras" <paulus@samba.org>
Subject: Re: [POWERPC] mpc52xx: Amalgamated dts fixes and updates
In-Reply-To: <20080322001242.GA29812@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <47E2723D.1090101@grandegger.com> <47E281B6.20702@denx.de>
	<fa686aa40803201650t289cd800gfda389b192c1834c@mail.gmail.com>
	<47E2FC3E.1020705@semihalf.com>
	<fa686aa40803201720l3e42c983se121ebc257c89912@mail.gmail.com>
	<20080321235633.GB345@frozen.semihalf.com>
	<20080322001242.GA29812@localhost.localdomain>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, Mar 21, 2008 at 6:12 PM, David Gibson
<david@gibson.dropbear.id.au> wrote:
> On Sat, Mar 22, 2008 at 12:56:35AM +0100, Bartlomiej Sieka wrote:
>  > diff --git a/arch/powerpc/boot/dts/cm5200.dts b/arch/powerpc/boot/dts/cm5200.dts
>  > index 30737ea..8b2e8e4 100644
>  > --- a/arch/powerpc/boot/dts/cm5200.dts
>  > +++ b/arch/powerpc/boot/dts/cm5200.dts
>  > @@ -159,6 +159,7 @@
>  >               };
>  >
>  >               dma-controller@1200 {
>  > +                     device_type = "dma-controller";
>
>  This is not right.  If adding device_type here fixes something, then
>  the driver is wrong and should be fixed instead.

I just sent a patch that fixes the driver bug.

Cheers,
g.

-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
