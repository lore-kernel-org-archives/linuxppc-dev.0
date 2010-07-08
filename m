Return-Path: <kumar.gala@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 1AC0EB6EEE
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu,  8 Jul 2010 22:40:32 +1000 (EST)
Subject: Re: [1/2] powerpc/crashdump: Fix issues with kexec and 36bit physical
	addr
Mime-Version: 1.0 (Apple Message framework v1078)
Content-Type: text/plain; charset=us-ascii
From: Kumar Gala <kumar.gala@freescale.com>
In-Reply-To: <1278586190.28659.94.camel@pasglop>
Date: Thu, 8 Jul 2010 07:40:12 -0500
Message-Id: <F4BDFB0D-51C0-49C1-918F-FAC0DD565E63@freescale.com>
References: <1278535881-6463-1-git-send-email-msm@freescale.com>
	<20100708-mitltonm-msm-reply@mdm.bga.com>
	<1278586190.28659.94.camel@pasglop>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Matthew McClintock <msm@freescale.com>, linuxppc-dev@lists.ozlabs.org,
	Milton Miller <miltonm@bga.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Jul 8, 2010, at 5:49 AM, Benjamin Herrenschmidt wrote:

> On Thu, 2010-07-08 at 04:07 -0500, Milton Miller wrote:
>> On Wed, 07 Jul 2010 around 10:51:20 -0000 Matthew McClintock wrote:
>>> 
>>> Fix sizes of variables so correct values are exported via /proc.
>>> Cast variable in comparison to avoid compiler error.
>>> 
> 
> I'm afraid I already pulled that in. Please send a fixup patch.
> 
> Cheers,
> Ben.

pulled into which tree?

- k
