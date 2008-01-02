Return-Path: <glikely@secretlab.ca>
Received: from an-out-0708.google.com (an-out-0708.google.com [209.85.132.243])
	by ozlabs.org (Postfix) with ESMTP id 58FF8DDE23
	for <linuxppc-dev@ozlabs.org>; Thu,  3 Jan 2008 03:12:54 +1100 (EST)
Received: by an-out-0708.google.com with SMTP id c37so1045580anc.78
	for <linuxppc-dev@ozlabs.org>; Wed, 02 Jan 2008 08:12:53 -0800 (PST)
Message-ID: <fa686aa40801020812o471e18e6u9fe20676d320e958@mail.gmail.com>
Date: Wed, 2 Jan 2008 09:12:52 -0700
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@secretlab.ca
To: "Timur Tabi" <timur@freescale.com>
Subject: Re: [PATCH] ASoC drivers for the Freescale MPC8610 SoC
In-Reply-To: <477BAB67.4080003@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <11981089894052-git-send-email-timur@freescale.com>
	<9e4733910801010925j67192427o4e0e824b9d7e0ad0@mail.gmail.com>
	<9e4733910801010942y47e4cdbfge5e0d3e44ab96760@mail.gmail.com>
	<477BAB67.4080003@freescale.com>
Cc: linuxppc-dev@ozlabs.org, alsa-devel@alsa-project.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On 1/2/08, Timur Tabi <timur@freescale.com> wrote:
> Jon Smirl wrote:
> > If that's the case the cs4270 should be in the i2c bus node (missing
> > currently) and then a link from the SSI bus would point to it.
>
> The CS4270 is a child of both the I2C bus *and* the SSI bus.  It needs
> to have two nodes, one under each.  Your're right in that there needs to
> be a link, but until the code is updated to ASoC V2, I think it's
> premature to add that support.

Why not be a child of the i2c bus with a phandle to the ssi bus?  That
is the direction we've gone with other multi attachment devices.  (ie.
Ethernet PHYs.  Child of the MDIO node, phandle to link the Ethernet
controller with the PHY)

Cheers,
g.

-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
grant.likely@secretlab.ca
(403) 399-0195
