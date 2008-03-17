Return-Path: <John.Linn@xilinx.com>
Received: from outbound5-dub-R.bigfish.com (outbound-dub.frontbridge.com
	[213.199.154.16])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "*.bigfish.com", Issuer "*.bigfish.com" (not verified))
	by ozlabs.org (Postfix) with ESMTPS id 659A8DE025
	for <linuxppc-dev@ozlabs.org>; Tue, 18 Mar 2008 07:10:40 +1100 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Subject: RE: [PATCH] [POWERPC] Xilinx: Boot: Fix 16550 UART initialization
Date: Mon, 17 Mar 2008 14:10:33 -0600
In-Reply-To: <fa686aa40803171308h5ef7f8a9m5119ef12d8c87980@mail.gmail.com>
References: <20080317164202.7E8A41A3806F@mail213-sin.bigfish.com>
	<fa686aa40803171247j709bc554pe709628c46205600@mail.gmail.com>
	<20080317195756.4F7411BE807D@mail119-dub.bigfish.com>
	<fa686aa40803171308h5ef7f8a9m5119ef12d8c87980@mail.gmail.com>
From: "John Linn" <John.Linn@xilinx.com>
To: "Grant Likely" <grant.likely@secretlab.ca>
Message-Id: <20080317201035.CBCAC1468068@mail95-dub.bigfish.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Great, I'll do that.

Does this also apply to my other patch, Adding 8250 console support to
OF serial, as it's not clear to me when to assume the UART is already
setup or not?

Thanks,
John

-----Original Message-----
From: glikely@secretlab.ca [mailto:glikely@secretlab.ca] On Behalf Of
Grant Likely
Sent: Monday, March 17, 2008 2:08 PM
To: John Linn
Cc: linuxppc-dev@ozlabs.org; jwboyer@linux.vnet.ibm.com
Subject: Re: [PATCH] [POWERPC] Xilinx: Boot: Fix 16550 UART
initialization

On Mon, Mar 17, 2008 at 1:57 PM, John Linn <John.Linn@xilinx.com> wrote:
> That makes sense.  Since I'm not using a boot loader I didn't realize
>  that.
>
>  I'm not sure how hard it will be to get the data from the device tree
at
>  that time.

You should be good.  It is now possible to read data from the device
tree at platform_init() time.

Cheers,
g.

>  What about checking to see if it's setup assuming that's possible by
>  looking at registers, and then not messing with it if it's already
>  setup, otherwise do what my patch does.

Ugh.  The old arch/ppc code used to do this and it was kind of ugly
and fragile.  I'd rather avoid doing it again.

Cheers,
g.

--=20
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
