Return-Path: <glikely@secretlab.ca>
Received: from mail-gx0-f16.google.com (mail-gx0-f16.google.com
	[209.85.217.16]) by ozlabs.org (Postfix) with ESMTP id 404E8DE038
	for <linuxppc-dev@ozlabs.org>; Wed,  7 Jan 2009 14:26:32 +1100 (EST)
Message-ID: <fa686aa40901061926o6858602em60281a1e39daa0c2@mail.gmail.com>
Date: Tue, 6 Jan 2009 20:26:31 -0700
From: "Grant Likely" <grant.likely@secretlab.ca>
To: "Li Yang" <LeoLi@freescale.com>,
	"Wood Scott-B07421" <scottwood@freescale.com>,
	linuxppc-dev@ozlabs.org, devicetree-discuss@ozlabs.org
Subject: Re: The usage of compatible 'simple-bus'
In-Reply-To: <20090107020006.GD13731@yookeroo.seuss>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <20090106014323.GB29456@yookeroo.seuss>
	<3A45394FD742FA419B760BB8D398F9ED0B38C9@zch01exm26.fsl.freescale.net>
	<20090107020006.GD13731@yookeroo.seuss>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, Jan 6, 2009 at 7:00 PM, David Gibson
<david@gibson.dropbear.id.au> wrote:
> As Grant says, you're thinking about what drivers will do with things
> rather than what the actual hardware setup is, which is what the
> device tree should describe.
>
> I see two sensible options for this situation:
>        - Move the MDIO node to outside the gianfar MAC node.  I think
> this is already done on some boards with gianfar?

mpc5200 FEC is another example of this.

>        - Explicitly add the gianfar device to the list of things to
> scan for of_platform subdevices.

Ack.  I 100% agree.

g.

-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
