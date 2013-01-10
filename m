Return-Path: <B07421@freescale.com>
Received: from am1outboundpool.messaging.microsoft.com
 (am1ehsobe004.messaging.microsoft.com [213.199.154.207])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id B45B62C00BD
 for <linuxppc-dev@ozlabs.org>; Fri, 11 Jan 2013 06:48:49 +1100 (EST)
Date: Thu, 10 Jan 2013 13:48:38 -0600
From: Scott Wood <scottwood@freescale.com>
Subject: Re: [PATCH] Added device tree binding for TDM and TDM phy
To: Singh Sandeep-B37400 <B37400@freescale.com>
References: <1357133120-2271-1-git-send-email-Sandeep@freescale.com>
 <3F1D9DCAAB49B94D88DBE05911FA4E6E69CEB8@039-SN1MPN1-005.039d.mgd.msft.net>
 <1357776425.18196.18@snotra>
 <3F1D9DCAAB49B94D88DBE05911FA4E6E69E4F0@039-SN1MPN1-005.039d.mgd.msft.net>
In-Reply-To: <3F1D9DCAAB49B94D88DBE05911FA4E6E69E4F0@039-SN1MPN1-005.039d.mgd.msft.net>
 (from B37400@freescale.com on Thu Jan 10 03:24:21 2013)
Message-ID: <1357847318.27576.9@snotra>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; delsp=Yes; format=Flowed
Cc: Wood Scott-B07421 <B07421@freescale.com>,
 "devicetree-discuss@lists.ozlabs.org"
 <devicetree-discuss@lists.ozlabs.org>,
 Aggrwal Poonam-B10812 <B10812@freescale.com>,
 "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 01/10/2013 03:24:21 AM, Singh Sandeep-B37400 wrote:
> > > > +- compatible
> > > > +    Value type: <string>
> > > > +    Definition: Should contain generic compatibility like
> > > "tdm-phy-slic"
> > > > or
> > > > +    "tdm-phy-e1" or "tdm-phy-t1".
> >
> > Does this "generic" string (plus the other properties) tell you all =20
> you
> > need to know about the device?  If there are other possible =20
> "generic"
> > compatibles, they should be listed or else different people will =20
> make up
> > different strings for the same thing.
>=20
> This property will describe the type of device, and will help TDM =20
> framework
> to know if it is E1/T1/SLIC device. Further details can be extracted =20
> from other
> compatible strings.
> There are only three generic compatibles field types, which are =20
> already mentioned
> in definition. Do I need to make this thing more clear.

The word "like" suggests that there are other possibilites.  It would =20
be clearer as:

Definition: One of "tdm-phy-slic", "tdm-phy-e1", or "tdm-phy-t1".

-Scott=
