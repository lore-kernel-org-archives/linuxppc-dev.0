Return-Path: <John.Linn@xilinx.com>
Received: from outbound7-dub-R.bigfish.com (outbound-dub.frontbridge.com
	[213.199.154.16])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "*.bigfish.com", Issuer "*.bigfish.com" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 81F17DDE0E
	for <linuxppc-embedded@ozlabs.org>;
	Fri,  7 Mar 2008 06:43:35 +1100 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Subject: RE: Problems in fixup_device function
Date: Thu, 6 Mar 2008 12:40:16 -0700
In-Reply-To: <fa686aa40803061138s8ed3d6r53cff6324fdf99f2@mail.gmail.com>
References: <20080306192149.4A0A9708064@mail119-dub.bigfish.com>
	<fa686aa40803061138s8ed3d6r53cff6324fdf99f2@mail.gmail.com>
From: "John Linn" <John.Linn@xilinx.com>
To: "Grant Likely" <grant.likely@secretlab.ca>
Message-Id: <20080306194022.186C64F0065@mail174-dub.bigfish.com>
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

I am loading the mac address into the data of the platform device.

-- John

-----Original Message-----
From: glikely@secretlab.ca [mailto:glikely@secretlab.ca] On Behalf Of
Grant Likely
Sent: Thursday, March 06, 2008 12:39 PM
To: John Linn
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: Problems in fixup_device function

On Thu, Mar 6, 2008 at 12:21 PM, John Linn <John.Linn@xilinx.com> wrote:
>
>
>
>
> I've added some code to virtex_device_fixup and am seeing some strange
side
> affects.  I've added code to read from an iic device and populate the
mac
> address including ioremap.  The code works fine, but the side affects
are
> not fine.

Specifically, what are you trying to do?  Are you modifying the data
in the platform device?

Cheers,
g.

--=20
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
