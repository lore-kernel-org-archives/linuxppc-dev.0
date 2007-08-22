Return-Path: <stephen.neuendorffer@xilinx.com>
Received: from outbound5-sin-R.bigfish.com (outbound-sin.frontbridge.com
	[207.46.51.80])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "*.bigfish.com", Issuer "*.bigfish.com" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 386DADDEB6
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 23 Aug 2007 02:38:23 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: [PATCH 1/3] Add generic configuration option to enable all xilinx
	drivers.
Date: Wed, 22 Aug 2007 09:35:47 -0700
In-Reply-To: <fa686aa40708212028n6dfe02fend98298fc945f063e@mail.gmail.com>
From: "Stephen Neuendorffer" <stephen.neuendorffer@xilinx.com>
To: "Grant Likely" <grant.likely@secretlab.ca>,
	"Wolfgang Reissnegger" <wre@xilinx.com>
Message-Id: <20070822163551.8F0118D0055@mail31-sin.bigfish.com>
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

=20

> -----Original Message-----
> From: glikely@secretlab.ca [mailto:glikely@secretlab.ca] On=20
> Behalf Of Grant Likely
> Sent: Tuesday, August 21, 2007 8:28 PM
> To: Wolfgang Reissnegger
> Cc: linuxppc-embedded@ozlabs.org; Stephen Neuendorffer
> Subject: Re: [PATCH 1/3] Add generic configuration option to=20
> enable all xilinx drivers.
>=20
> On 8/21/07, wolfgang.reissnegger@xilinx.com
> <wolfgang.reissnegger@xilinx.com> wrote:
> > From: Stephen Neuendorffer <stephen.neuendorffer@xilinx.com>
> >
> > In the future, this will be used to provide similar configuration
> > for PowerPC and Microblaze.
>=20
> I'm not convinced that this change is worth it since there is only one
> in-tree driver that uses it.  I'd maintain it separately in your tree
> until other drivers or the microblaze stuff is ready for merging.

I have at least one more driver that will use it, for the ICAP, and
joachim's AC97 driver should use it too.

In any event, my intention with all of this is to start small to figure
out how
to do it...  Plus I think it will be much easier to manage our tree if
basic
changes like this are merged long before arch/microblaze.

Steve=20
