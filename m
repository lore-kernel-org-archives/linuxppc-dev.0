Return-Path: <ppc6dev@digitaldans.com>
Received: from digitaldans.com (digitaldans.com [69.36.177.99])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 94663B7D8B
	for <linuxppc-dev@ozlabs.org>; Sat, 12 Jun 2010 10:00:18 +1000 (EST)
In-Reply-To: <AANLkTilK4YkRMJqlcRDOAlGBzpdlZuSo9NF5NrRNocHT@mail.gmail.com>
References: <AANLkTilK4YkRMJqlcRDOAlGBzpdlZuSo9NF5NrRNocHT@mail.gmail.com>
Mime-Version: 1.0 (Apple Message framework v753.1)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <33BD8E86-9397-432A-97BF-F154812C157B@digitaldans.com>
From: Dan Malek <ppc6dev@digitaldans.com>
Subject: Re: Request review of device tree documentation
Date: Fri, 11 Jun 2010 16:47:26 -0700
To: Grant Likely <grant.likely@secretlab.ca>
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


Hi Grant.

On Jun 11, 2010, at 3:59 PM, Grant Likely wrote:

> I've been doing a bit of work on some introductory level documentation
> of the flattened device tree.

Wow, I feel empowered to create device trees now :-)
Seriously, I never understood this well and this is a
great document.

I have one source of confusion.  Your first Initial structure
example uses 'compatible' to describe the machine, the
paragraph below then mentions the 'model' property,
and all subsequent examples use model.

Does this mean if I use just the single line in the dts,
using 'compatible' implies the ARM machine ID?  If I
have more description I use 'model'?

Thanks.

	-- Dan
