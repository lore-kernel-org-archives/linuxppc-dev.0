Return-Path: <glikely@secretlab.ca>
Received: from mail-yx0-f170.google.com (mail-yx0-f170.google.com
	[209.85.213.170]) by ozlabs.org (Postfix) with ESMTP id AB427B7D61
	for <linuxppc-dev@ozlabs.org>; Sun, 13 Jun 2010 09:09:58 +1000 (EST)
Received: by yxs7 with SMTP id 7so118623yxs.15
	for <linuxppc-dev@ozlabs.org>; Sat, 12 Jun 2010 16:09:57 -0700 (PDT)
MIME-Version: 1.0
Sender: glikely@secretlab.ca
In-Reply-To: <20100612221554.GA17876@lixom.net>
References: <AANLkTilK4YkRMJqlcRDOAlGBzpdlZuSo9NF5NrRNocHT@mail.gmail.com>
	<33BD8E86-9397-432A-97BF-F154812C157B@digitaldans.com>
	<AANLkTilv6TtPZs0DAwd8JlSV_J3VvMsvtVVOOeQauOIn@mail.gmail.com>
	<20100612221554.GA17876@lixom.net>
From: Grant Likely <grant.likely@secretlab.ca>
Date: Sat, 12 Jun 2010 17:09:36 -0600
Message-ID: <AANLkTimgvKoCBOkhVeLX-uHtRzFPMWpVtZNipKvekOJv@mail.gmail.com>
Subject: Re: Request review of device tree documentation
To: Olof Johansson <olof@lixom.net>
Content-Type: text/plain; charset=ISO-8859-1
Cc: microblaze-uclinux@itee.uq.edu.au,
	devicetree-discuss <devicetree-discuss@lists.ozlabs.org>,
	linuxppc-dev <linuxppc-dev@ozlabs.org>, Mitch Bradley <wmb@firmworks.com>,
	Dan Malek <ppc6dev@digitaldans.com>,
	Jeremy Kerr <jeremy.kerr@canonical.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sat, Jun 12, 2010 at 4:15 PM, Olof Johansson <olof@lixom.net> wrote:
> On Sat, Jun 12, 2010 at 12:53:59AM -0600, Grant Likely wrote:
>
>> I also changed the property in the cpu nodes from model to compatible
>> so that the exact CPU version can be specified. =A0This isn't actually
>> in any spec anywhere, but I need something to properly identify the
>> different ARM cores.
>
> I don't see why this has to be in the device tree. It's not there on PPC.
> The exact CPU version is found through the PVR register on PPC, ARM also
> has cpu version and feature registers for runtime probing.

I had been told that they runtime registers weren't reliable.  If I'm
misinformed, then yes the compatible value can be dropped from the cpu
nodes.

g.
