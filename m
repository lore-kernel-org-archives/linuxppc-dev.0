Return-Path: <laurent.pinchart@technotrade.biz>
Received: from outmx003.isp.belgacom.be (outmx003.isp.belgacom.be
	[195.238.4.100])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 36911DDDF6
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 24 Jan 2007 18:57:35 +1100 (EST)
Received: from outmx003.isp.belgacom.be (localhost.localdomain [127.0.0.1])
	by outmx003.isp.belgacom.be (8.13.4/8.12.11/Skynet-OUT-2.22) with ESMTP
	id l0O7vSmM012026
	for <linuxppc-embedded@ozlabs.org>; Wed, 24 Jan 2007 08:57:30 +0100
	(envelope-from <laurent.pinchart@technotrade.biz>)
From: Laurent Pinchart <laurent.pinchart@technotrade.biz>
To: linuxppc-embedded@ozlabs.org
Subject: Re: JTAG emulator for MPC8548E (v2)
Date: Wed, 24 Jan 2007 08:57:19 +0100
References: <BD261180E6D35F4D9D32F3E44FD3D901062D1E42@EMPBEDEX.empirix.com>
	<528646bc0701230956v26e34c5bx7d3fc082fe1d20c9@mail.gmail.com>
	<BD261180E6D35F4D9D32F3E44FD3D901062D1F17@EMPBEDEX.empirix.com>
In-Reply-To: <BD261180E6D35F4D9D32F3E44FD3D901062D1F17@EMPBEDEX.empirix.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200701240857.19428.laurent.pinchart@technotrade.biz>
Cc: "Morrison, Tom" <tmorrison@empirix.com>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

> We actually have one of these - and the H/W engineer is NOT
> happy at all. Apparently, it is NOT that stable for single
> step operations, and does NOT give a consistent view of the
> All the internal registers and/or the ability to view all
> the registers natively!
>
> I am hoping for one that is more consistent and aware (and stable).

Just to add my 2 cents, I had problems with the BDI-2000 as well. The unit I 
got from Abatron had a hardware problem (the ethernet controller would 
sometimes reset when the BDI initialised the target PPC processor). Their 
French distributor agreed to replace it after making sure it was indeed a 
hardware issue (they seem to assume end-users have a negative IQ and are 
unable to diagnose such a hardware problem themselves).

The new unit works *mostly* fine. No debugging issue (not that I use it that 
much anyway, now that the board boots Linux), but still a flash programming 
issue. Programming the target parallel NOR flash works in slow JTAG mode, but 
not in faster mode using the internal workspace. I reported the problem 
several months ago and still haven't received any solution. It might not be 
Abatron's fault, the French distributor might not have reported the problem 
to them. Abatron people speak German only, and will not respond to e-mails 
written in English (nor will they talk to you on the phone, they just hang 
up).

The BDI-2000 is a nice product, but has a few bugs, is IMHO overprized and has 
one of the worst support service I've had to deal with.

Laurent Pinchart
