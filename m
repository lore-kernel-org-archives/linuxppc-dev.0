Return-Path: <glikely@secretlab.ca>
Received: from mail-gy0-f170.google.com (mail-gy0-f170.google.com
	[209.85.160.170]) by ozlabs.org (Postfix) with ESMTP id EB817B7D85
	for <linuxppc-dev@ozlabs.org>; Sat, 12 Jun 2010 16:54:21 +1000 (EST)
Received: by gyf2 with SMTP id 2so1361060gyf.15
	for <linuxppc-dev@ozlabs.org>; Fri, 11 Jun 2010 23:54:19 -0700 (PDT)
MIME-Version: 1.0
Sender: glikely@secretlab.ca
In-Reply-To: <33BD8E86-9397-432A-97BF-F154812C157B@digitaldans.com>
References: <AANLkTilK4YkRMJqlcRDOAlGBzpdlZuSo9NF5NrRNocHT@mail.gmail.com>
	<33BD8E86-9397-432A-97BF-F154812C157B@digitaldans.com>
From: Grant Likely <grant.likely@secretlab.ca>
Date: Sat, 12 Jun 2010 00:53:59 -0600
Message-ID: <AANLkTilv6TtPZs0DAwd8JlSV_J3VvMsvtVVOOeQauOIn@mail.gmail.com>
Subject: Re: Request review of device tree documentation
To: Dan Malek <ppc6dev@digitaldans.com>, Mitch Bradley <wmb@firmworks.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: microblaze-uclinux@itee.uq.edu.au,
	devicetree-discuss <devicetree-discuss@lists.ozlabs.org>,
	linuxppc-dev <linuxppc-dev@ozlabs.org>, Olof Johansson <olof@lixom.net>,
	Jeremy Kerr <jeremy.kerr@canonical.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Jun 11, 2010 at 5:47 PM, Dan Malek <ppc6dev@digitaldans.com> wrote:
>
> Hi Grant.
>
> On Jun 11, 2010, at 3:59 PM, Grant Likely wrote:
>
>> I've been doing a bit of work on some introductory level documentation
>> of the flattened device tree.
>
> Wow, I feel empowered to create device trees now :-)
> Seriously, I never understood this well and this is a
> great document.

Hey, thanks!  That's a fantastic compliment!

> I have one source of confusion. =A0Your first Initial structure
> example uses 'compatible' to describe the machine, the
> paragraph below then mentions the 'model' property,
> and all subsequent examples use model.
>
> Does this mean if I use just the single line in the dts,
> using 'compatible' implies the ARM machine ID? =A0If I
> have more description I use 'model'?

No, that is just a reflection of a late change I made to the document.
 It should be compatible all the way down.  I was trying to keep
things simple because on a lot of boards both compatible and model
properties will exist in the root node.  I started writing with model,
and then changed it last minute without fixing everything up which is
why the document was confusing.

I've fixed it now if you want to take a look.

I also changed the property in the cpu nodes from model to compatible
so that the exact CPU version can be specified.  This isn't actually
in any spec anywhere, but I need something to properly identify the
different ARM cores.

Mitch, I know you were working on a draft ARM binding a while ago,
have you resurrected it at all?  How do you think the core should be
identified?

Cheers,
g.
