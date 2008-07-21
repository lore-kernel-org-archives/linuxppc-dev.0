Return-Path: <segher@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 0EA8BDDEF9
	for <linuxppc-dev@ozlabs.org>; Tue, 22 Jul 2008 08:13:41 +1000 (EST)
In-Reply-To: <20080721211344.GA13268@loki.buserror.net>
References: <20080708042631.GB7328@yookeroo.seuss>
	<20080709040925.GA13810@secretlab.ca> <487AA17E.6000808@gmail.com>
	<20080721211344.GA13268@loki.buserror.net>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <137baed45f975ea9061f6a7a2cc18fbc@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: Mikrotik RouterBoard 333
Date: Tue, 22 Jul 2008 00:13:19 +0200
To: Scott Wood <scottwood@freescale.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

>> Other than that quibble, I agree that burning the blob into the 
>> firmware
>> so that the firmware must be recompiled and reburned to change the 
>> blob
>> is very undesirable.
>
> I thought the device tree was *supposed* to be an interface between the
> firmware and the kernel?  What if the firmware produces the tree
> dynamically?  What if the firmware itself depends on having the device 
> tree
> in order to operate?

Sure.  But in the case where the firmware just passes the
kernel some fixed blob, it is easier for everyone to include
that blob with the kernel instead.


Segher
