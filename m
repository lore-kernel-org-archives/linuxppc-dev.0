Return-Path: <scottwood@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 6C9A5B7C98
	for <linuxppc-dev@ozlabs.org>; Fri, 26 Mar 2010 02:17:33 +1100 (EST)
Message-ID: <4BAB7E67.6040707@freescale.com>
Date: Thu, 25 Mar 2010 10:16:55 -0500
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH] powerpc/fsl: add device tree binding for QE firmware
References: <1269380552-10418-1-git-send-email-timur@freescale.com>	<fa686aa41003232307s39af071bn6377800951d6615c@mail.gmail.com>	<ed82fe3e1003240505h59d29c83x6948f8b3b70c4570@mail.gmail.com>	<90D93687-940F-47FB-8CEA-F3C065EA611D@kernel.crashing.org>	<fa686aa41003241007mf6052d5s4643795f4a87cdcf@mail.gmail.com>	<4BAA4C8A.70104@freescale.com>
	<65327.84.105.60.153.1269481760.squirrel@gate.crashing.org>
In-Reply-To: <65327.84.105.60.153.1269481760.squirrel@gate.crashing.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-dev@ozlabs.org, devicetree-discuss@lists.ozlabs.org,
	Timur Tabi <timur@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Segher Boessenkool wrote:
> As far as I can see, you want that indirection node so that you
> safe space in the DTB.

Probably more of a general desire to not duplicate things that don't 
need to be duplicated...  I don't think the space issue is critical in 
this particular case.

> With real OF it is trivial to not have
> multiple copies of the data if you want a few properties with
> the same data.  There is no reason this could not be done in DTB
> as well (and some way in DTS to express that, or maybe the tools
> could auto-detect it, whatever).

You object to some slight complexity in the device binding, and want to 
replace it with an incompatible, more complex change to the blob format?

>>> That is a good question.  Why is it necessary to pass the blob via the
>>> tree?
>> Because sometimes the firmware is needed before networking or serial I/O
>> can function.
> 
> Can't you link it into the kernel then?  Seems a better place for
> it to me.  Of course you said something about GPL, heh.

U-Boot needs it too.

-Scott
