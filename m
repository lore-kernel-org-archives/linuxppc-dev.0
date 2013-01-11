Return-Path: <B37400@freescale.com>
Received: from tx2outboundpool.messaging.microsoft.com
 (tx2ehsobe005.messaging.microsoft.com [65.55.88.15])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 2C27D2C0087
 for <linuxppc-dev@ozlabs.org>; Fri, 11 Jan 2013 17:01:53 +1100 (EST)
From: Singh Sandeep-B37400 <B37400@freescale.com>
To: Wood Scott-B07421 <B07421@freescale.com>
Subject: RE: [PATCH] Added device tree binding for TDM and TDM phy
Date: Fri, 11 Jan 2013 06:01:47 +0000
Message-ID: <3F1D9DCAAB49B94D88DBE05911FA4E6E69F5FD@039-SN1MPN1-005.039d.mgd.msft.net>
References: <1357133120-2271-1-git-send-email-Sandeep@freescale.com>
 <3F1D9DCAAB49B94D88DBE05911FA4E6E69CEB8@039-SN1MPN1-005.039d.mgd.msft.net>
 <1357776425.18196.18@snotra>
 <3F1D9DCAAB49B94D88DBE05911FA4E6E69E4F0@039-SN1MPN1-005.039d.mgd.msft.net>
 <1357847318.27576.9@snotra>
In-Reply-To: <1357847318.27576.9@snotra>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Cc: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>,
 "devicetree-discuss@lists.ozlabs.org"
 <devicetree-discuss@lists.ozlabs.org>,
 Aggrwal Poonam-B10812 <B10812@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

> -----Original Message-----
> From: Wood Scott-B07421
> Sent: Friday, January 11, 2013 1:19 AM
> To: Singh Sandeep-B37400
> Cc: Wood Scott-B07421; devicetree-discuss@lists.ozlabs.org; linuxppc-
> dev@ozlabs.org; Aggrwal Poonam-B10812
> Subject: Re: [PATCH] Added device tree binding for TDM and TDM phy
>=20
> On 01/10/2013 03:24:21 AM, Singh Sandeep-B37400 wrote:
> > > > > +- compatible
> > > > > +    Value type: <string>
> > > > > +    Definition: Should contain generic compatibility like
> > > > "tdm-phy-slic"
> > > > > or
> > > > > +    "tdm-phy-e1" or "tdm-phy-t1".
> > >
> > > Does this "generic" string (plus the other properties) tell you all
> > you
> > > need to know about the device?  If there are other possible
> > "generic"
> > > compatibles, they should be listed or else different people will
> > make up
> > > different strings for the same thing.
> >
> > This property will describe the type of device, and will help TDM
> > framework to know if it is E1/T1/SLIC device. Further details can be
> > extracted from other compatible strings.
> > There are only three generic compatibles field types, which are
> > already mentioned in definition. Do I need to make this thing more
> > clear.
>=20
> The word "like" suggests that there are other possibilites.  It would be
> clearer as:
>=20
> Definition: One of "tdm-phy-slic", "tdm-phy-e1", or "tdm-phy-t1".
>=20
> -Scott
Ok, thanks for your comments.
